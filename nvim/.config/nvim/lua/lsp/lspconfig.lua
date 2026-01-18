-- Language Server Protocol Setup
--
-- These GLOBAL keymaps are created unconditionally when Nvim starts:
-- "gra" (Normal and Visual mode) is mapped to vim.lsp.buf.code_action()
-- "gri" is mapped to vim.lsp.buf.implementation()
-- "grn" is mapped to vim.lsp.buf.rename()
-- "grr" is mapped to vim.lsp.buf.references()
-- "grt" is mapped to vim.lsp.buf.type_definition()
-- "gO" is mapped to vim.lsp.buf.document_symbol()
-- CTRL-S (Insert mode) is mapped to vim.lsp.buf.signature_help()
-- "an" and "in" (Visual and Operator-pending mode) are mapped to outer and inner incremental selections, respectively, using vim.lsp.buf.selection_range() 
--
-- 'omnifunc' is set to vim.lsp.omnifunc(), use i_CTRL-X_CTRL-O to trigger completion.
-- 'tagfunc' is set to vim.lsp.tagfunc(). This enables features like go-to-definition, :tjump, and keymaps like CTRL-], CTRL-W_], CTRL-W_} to utilize the language server.
-- 'formatexpr' is set to vim.lsp.formatexpr(), so you can format lines via gq if the language server supports it.
-- To opt out of this use gw instead of gq, or clear 'formatexpr' on LspAttach.
-- K is mapped to vim.lsp.buf.hover() unless 'keywordprg' is customized or a custom keymap for K exists.
-- Document colors are enabled for highlighting color references in a document.
-- To opt out call vim.lsp.document_color.enable(false, args.buf) on LspAttach.

local on_attach = function(client, bufnr)
    local bufmap = function(keys, func)
        vim.keymap.set('n', keys, func, { buffer = bufnr })
    end

    bufmap('<leader>a', vim.lsp.buf.code_action)

    bufmap('gr', require('telescope.builtin').lsp_references)
    bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
    bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

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


require('mason').setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "cssls", "gopls",
        "lua_ls", "pyright",
        "ruff", "ts_ls" }
}

local capabilities = require('blink.cmp').get_lsp_capabilities()
vim.lsp.config("*", {
    capabilities = capabilities,
    root_markers = { ".git" },
});

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    end
})

-- vim.lsp.config['luals'] = {
--  -- Command and arguments to start the server.
--  cmd = { 'lua-language-server' },
--  -- Filetypes to automatically attach to.
--  filetypes = { 'lua' },
--  -- Sets the "workspace" to the directory where any of these files is found.
--  -- Files that share a root directory will reuse the LSP server connection.
--  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
--  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
--  -- Specific settings to send to the server. The schema is server-defined.
--  -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
--  settings = {
--    Lua = {
--      runtime = {
--        version = 'LuaJIT',
--      }
--    }
--  }
-- }

require("mason-nvim-dap").setup({
    ensure_installed = { "python", "delve" },
    handlers = {}
})
