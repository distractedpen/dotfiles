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
    bufmap('<leader>hh', vim.lsp.buf.signature_help)

    bufmap('gr', require('telescope.builtin').lsp_references)
    bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
    bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)


    bufmap('K', vim.lsp.buf.hover)

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {})

    local c = client.capabilities
    if client.name == 'pyright' then
        c.hover = false
    end

    if client.name == 'pylsp' then
        c.rename = false
        c.signature_help = false
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

    ["efm"] = function()
        local languages = require('efmls-configs.defaults').languages()

        -- additional formatters and linters
        -- local jq = require("efmls-configs.formatters.jq")
        local prettier = require("efmls-configs.formatters.prettier")
        local jq = require("efmls-configs.linters.jq")
        languages = vim.tbl_extend('force', languages, {
         json = { jq, prettier },
        })
        --

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


    ["omnisharp"] = function()
        require('lspconfig').omnisharp.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { vim.fn.stdpath("data") .. "/mason/packages/omnisharp/omnisharp" },
            handlers = {
                ["textDocument/definition"] = require("omnisharp_extended").handler,
            },
            enable_editorconfig_support = true,
            enable_ms_build_load_projects_on_demand = false,
            enable_roslyn_analyzers = true,
            organize_imports_on_format = true,
            enable_import_completion = true,
            sdk_include_prereleases = true,
        })
    end,

    ["tailwindcss"] = function()
        require('lspconfig').tailwindcss.setup({
            -- capabilities = capabilities,
            -- on_attach = on_attach,
            -- settings = {
            -- },
        })
    end,

})
