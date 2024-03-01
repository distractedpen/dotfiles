local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>A", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>H", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<leader>P", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>N", function() harpoon:list():next() end)


