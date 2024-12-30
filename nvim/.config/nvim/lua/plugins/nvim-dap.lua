-- DAP
local dap = require("dap")
local dapWidgets = require("dap.ui.widgets")



-- Keybindings
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dc', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_into() end)
vim.keymap.set('n', '<F11>', function() dap.step_over() end)
vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<leader>dl', function() dap.run_last() end)
vim.keymap.set({ 'n', 'v' }, '<leader>dh', function() dapWidgets.hover() end)
vim.keymap.set({ 'n', 'v' }, '<leader>dp', function() dapWidgets.preview() end)
vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)


-- DAP UI
local dapui = require("dapui")
dapui.setup()

-- Keybindings

vim.keymap.set('n', '<leader>dt', function() dapui.toggle() end)

-- hook dapui into dap
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end

dap.listeners.before.event_exited_dapui_config = function()
    dapui.close()
end
