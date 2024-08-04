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


vim.keymap.set("n", "<Enter>", "<Plug>RDSendLine", {})
vim.keymap.set("v", "<Enter>", "<Plug>RSendSelection", {})

require("r").setup(opts)
