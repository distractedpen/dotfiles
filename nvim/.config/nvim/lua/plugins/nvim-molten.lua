-- Keybindings for Molten-nvim


vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>",
    { silent = true, desc = "Initialize the plugin"})

vim.keymap.set("n", "<leader>me", ":MoltenEvaluateOperator<CR>",
    { silent = true, desc = "Run operator selection"})

vim.keymap.set("n", "<leader>mr", ":MoltenEvaluateLine<CR>",
    { silent = true, desc = "evaluate line"})

vim.keymap.set("n", "<leader>mR", ":MoltenEvaluateLine<CR>",
    { silent = true, desc = "re-evaluate cell"})

vim.keymap.set("n", "<leader>mev", ":<C-u>MoltenEvaluateVisual<CR>gv",
    { silent = true, desc = "evaluate visual selection"})

vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>",
    { silent = true, desc = "molten delte cell"})

vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>",
    { silent = true, desc = "hide output"})

vim.keymap.set("n", "<leader>ms", ":noautocmd MoltenEnterOutput<CR>",
    { silent = true, desc = "show/enter output"})
