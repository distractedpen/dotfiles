-- Language Server Protocol Setup
local on_attach = function(client, bufnr)
    local bufmap = function(keys, func)
        vim.keymap.set('n', keys, func, { buffer = bufnr })
    end


    bufmap('<leader>r', vim.lsp.buf.rename)
    bufmap('<leader>a', vim.lsp.buf.code_action)

    bufmap('gd', vim.lsp.buf.definition)
    bufmap('gD', vim.lsp.buf.declaration)
    bufmap('gI', vim.lsp.buf.implementation)
    bufmap('<leader>D', vim.lsp.buf.type_definition)

    bufmap('gr', require('telescope.builtin').lsp_references)
    bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
    bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)


    bufmap('K', vim.lsp.buf.hover)

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {})

    -- conditonal options per lsp
    local rc = client.resolved_capabilities
    if client.name == 'pyright' then
        rc.hover = false
    end

    if client.name == 'pylsp' then
        rc.rename = false
        rc.signature_help = false
    end

end


-- Adding new filetypes for vim to handle 
vim.filetype.add({ extension = { templ = 'templ', } })

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup()
require('mason-lspconfig').setup_handlers({

    function(server_name)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
    end,

    ["pyright"] = function()
        require('lspconfig').pyright.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        useLibraryCodeForTypes = true,
                        diagnosticSeverityOverrides = {
                            reportGeneralTypeIssues = "none",
                            reportOptionalMemberAccess = "none",
                            reportOptionalSubscript = "none",
                            reportPrivateImportUsage = "none",
                        },
                        autoImportCompletions = false,
                    },
                    linting = {
                        pylintEnabled = false,
                    }
                }
            },
        }
    end,

    ["pylsp"] = function()
        require('lspconfig').pylsp.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                pylsp = {
                    builtin = {
                        installExtraArgs = { "flake8", 'pylint', 'pycodestyle'},
                    },
                    plugins = {
                        jedi_completion = { enabled = false },
                        rope_completion = { enabled = false },
                        pycodestyle = {
                            maxLineLength = 99,
                        },
                        pyflakes = { enabled = false },
                        flake8 = { enabled = false },
                    }
                }
            }
        }
    end,

    ["lua_ls"] = function()
        require('neodev').setup()
        require('lspconfig').lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        }
    end,

    ["jdtls"] = function()
        local runtimes = {}
        if vim.fn.has('mac') == 1 then
            runtimes = {
                {
                    name = "JavaSE-11",
                    path = "/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home",
                    default = false,
                },
                {
                    name = "JavaSE-17",
                    path = "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home",
                    default = false,
                },
                {
                    name = "JavaSE-20",
                    path = "/Library/Java/JavaVirtualMachines/temurin-20.jdk/Contents/Home",
                    default = true,
                }
            }
        end
        require('lspconfig').jdtls.setup({
            settings = {
                java = {
                    configuration = {
                        runtimes = runtimes
                    }
                }
            }
        })
    end,


    ["efm"] = function()
        local languages = require('efmls-configs.defaults').languages()
        local efmls_configs = {
            filetypes = vim.tbl_keys(languages),
            init_options = {
                documentFormatting = true,
                documentRangeFormatting = true
            },
            settings = {
                rootMarkers = { ".git/" },
                languages = languages,
            }
        }

        require("lspconfig").efm.setup(vim.tbl_extend('force', efmls_configs, {
            on_attach = on_attach,
            capabilities = capabilities,
        }))
    end,
})
