-- Treesitter configuration file

local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

nvim_treesitter.setup {
    ensure_installed = {
        'bash', 'c', 'css', 'html', 'javascript', 'json', 'lua', 'python',
        'rust', 'typescript', 'vim', 'yaml', 'markdown', 'vim', 'vimdoc',
    },
    sync_install = false,
    highlight = {
        enable = true,
    },
}
