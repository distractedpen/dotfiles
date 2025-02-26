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

    vim.api.nvim_buf_create_user_command(bufnr, 'F', function(_)
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


local capabilities = require('blink.cmp').get_lsp_capabilities()

require('mason').setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "cssls", "gopls",
        "lua_ls", "pyright",
        "pylsp", "ts_ls" }
}
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
                        installExtraArgs = { "flake8", 'pylint', 'pycodestyle' },
                    },
                    plugins = {
                        jedi_completion = { enabled = false },
                        rope_completion = { enabled = false },
                        pycodestyle = {
                            maxLineLength = 120,
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
})

require("mason-nvim-dap").setup({
    ensure_installed = { "python", "delve" },
    handlers = {}
})
