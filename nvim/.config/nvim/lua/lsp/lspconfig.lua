-- Language Server Protocol Setup

local on_attach = function(client, bufnr)-- {{{
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
end-- }}}

local capabilities = require('blink.cmp').get_lsp_capabilities()

require('mason').setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "cssls", "gopls",
        "lua_ls", "pyright",
        "ruff", "ts_ls" }
}


vim.lsp.enable("ruff")
vim.lsp.enable('pyright')
vim.lsp.enable('luals')
vim.lsp.enable('rust_analyzer')

vim.lsp.config['luals'] = {
 -- Command and arguments to start the server.
 cmd = { 'lua-language-server' },
 -- Filetypes to automatically attach to.
 filetypes = { 'lua' },
 -- Sets the "workspace" to the directory where any of these files is found.
 -- Files that share a root directory will reuse the LSP server connection.
 -- Nested lists indicate equal priority, see |vim.lsp.Config|.
 root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
 -- Specific settings to send to the server. The schema is server-defined.
 -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
 settings = {
   Lua = {
     runtime = {
       version = 'LuaJIT',
     }
   }
 }
}



vim.lsp.enable("gopls")
vim.lsp.enable("tflint");
vim.lsp.enable("terraformls");

require("mason-nvim-dap").setup({
    ensure_installed = { "python", "delve" },
    handlers = {}
})