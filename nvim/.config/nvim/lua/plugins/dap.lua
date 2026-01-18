-- DAP
local dap = require("dap")
local dapWidgets = require("dap.ui.widgets")


-- functions
local toggle_breakpoint = function() dap.toggle_breakpoint() end
local continue = function() dap.continue() end
local step_into = function() dap.step_into() end

local step_over = function() dap.step_over() end
local repl_open = function() dap.repl.open() end
local run_last = function() dap.run_last() end
local widget_hover = function() dapWidgets.hover() end
local widget_preview = function() dapWidgets.preview() end
local widget_frames = function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end
local widget_scopes = function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end


-- Keybindings
vim.keymap.set('n', '<leader>db', toggle_breakpoint)
vim.keymap.set('n', '<leader>dc', continue)
vim.keymap.set('n', '<F9>', step_into)
vim.keymap.set('n', '<F10>', step_over)
vim.keymap.set('n', '<leader>dr', repl_open)
vim.keymap.set('n', '<leader>dl', run_last)
vim.keymap.set({ 'n', 'v' }, '<leader>dh', widget_hover)
vim.keymap.set({ 'n', 'v' }, '<leader>dp', widget_preview)
vim.keymap.set('n', '<Leader>df', widget_frames)
vim.keymap.set('n', '<Leader>ds', widget_scopes)


-- DAP UI
local dapui = require("dapui")
dapui.setup()

-- DAP UI Functions
local ui_open = function() dapui.open() end
local ui_close = function() dapui.close() end
local ui_toggle = function() dapui.toggle() end

-- Keybindings

vim.keymap.set('n', '<leader>dt', ui_toggle)

-- hook dapui into dap
dap.listeners.before.attach.dapui_config = ui_open
dap.listeners.before.event_terminated.dapui_config = ui_close
dap.listeners.before.event_exited_dapui_config = ui_close

-- if a debugger is attached to the buffer
-- add the debugger's code actions to the menu

require('dap-python').setup("/home/" .. os.getenv("USER") .. "/.py3nvim/bin/python")
