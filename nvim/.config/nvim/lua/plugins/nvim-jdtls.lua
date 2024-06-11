
local M = {}

function M.setup()
    local jdtls = require("jdtls")
    local jdtls_setup = reqiure("jdtls.setup")
    local jdtls_dap = require("jdtls.dap")
    local home = os.getenv("HOME")


    local root_marker = {".git", "mvnw", "gradlew", "pom.xml", "build.gradle"}
    local root_dir = jdtls_setup.find_root(root_marker)

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = home .. ".cache/jdtls/workspaces" .. project_name

    local path_to_mason_packages = vim.fn.stdpath("data") .. "/mason/packages/"

    local path_to_jdtls = path_to_mason_packages .. "/jdtls"
    local path_to_jdebug = path_to_mason_packages .. "/java-debug-adapter"
    local path_to_jtest = path_to_mason_packages .. "/java-test"

    local path_to_config = path_to_jdtls .. "/config_mac_arm"
    local lombok_path = path_to_jdtls .. "/lombok.jar"


    local path_to_jar = path_to_jdtls .. "/plugins/org.eclipse.equinox.launcher.cocoa.macosx.aarch64_1.2.800.v20231003-1442.jar"

    local bundles = {
        vim.fn.glob(path_to_jdebug .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
    }

    vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_jtest .. "/extension/server/*.jar", true), "\n"))


    -- LSP settings for Java
    local on_attach = function(_, bufnr)
        jdtls.setup_dap({ hotcodereplace = "auto" })
        jdtls_dap.setup_dap_main_class_configs()
        jdtls_setup.add_commands()

        -- Create ':Format' command local to LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
            vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })

        require("lsp_signature").on_attach({
            bind = true,
            padding = "",
            handler_opts = {
                border = "rounded",
            },
            hint_prefix = "󱄑 ",
        }, bufnr)
    end


    -- require('lspsaga.init').

    local capabilities = {
        workspace = {
            configuration = true,
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                }
            }
        }
    }

    local config = {
        flags = {
            allow_incremental_sync = true,
        }
    }

    config.cmd = {
        -- 💀
        'java', -- or '/path/to/java17_or_newer/bin/java'
                -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '-javaagent:' .. lombok_path,
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        -- 💀
        '-jar', path_to_jar,

        -- 💀
        '-configuration', path_to_config,

        -- 💀
        -- See `data directory configuration` section in the README
        '-data', workspace_dir,
      }

    config.settings  {
        java = {
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                settings = {
                    url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
            eclipse = {
                downloadSources = true,
            },
            maven = {
                downloadSource = true,
            },
            signatureHelp = { enabled = true },
            contentProvider = { perferred = "fernflower" },
            completion = {
                favoriteStaticMembers = {},
                filteredTypes = {},
                importOrder = {
                    "java",
                    "javax",
                    "com",
                    "org",
                },
            },
            source = {
                organizeImport = {
                    starThreshold = 9999,
                    staticStartThresold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true
            }
        }

    }

    config.on_attach = on_attach
    config.capabilities = capabilities
    config.on_init = function(client, _)
        client.notify('workspace/didChangeConfiguration', { settings = config.settings })
    end

    local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    config.init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities,
    }

    require('jdtls').start_or_attach(config)

end

return M
