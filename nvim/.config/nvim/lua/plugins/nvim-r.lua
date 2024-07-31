local opts = {
    R_args = {"--quiet", "--no-save"},
    min_editor_width = 72,
    rconsole_width = 78,
    disable_cmds = {
        "RClearConsole",
        "RCustomStart",
        "RSPlot",
        "RSaveClose",
    },
}

if vim.env.R_AUTO_START == "true" then
    opts.auto_start = 1
    opts.objbr_auto_start = true
end

vim.api.nvim_buf_set_keymap(0, "n", "<leader>rl<Enter>", "<Plug>RDSendLine", {})
vim.api.nvim_buf_set_keymap(0, "v", "<leader>rs<Enter>", "<Plug>RSendSelection", {})

require("r").setup(opts)
