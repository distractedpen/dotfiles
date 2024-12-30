-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This holds teh configuration
local config = wezterm.config_builder()

-- Config
config.color_scheme = 'catppuccin-mocha'
config.window_background_opacity = 0.6
config.text_background_opacity = 0.6

-- update arrow key keybinds to hjkl
config.leader = { key = ' ', mods = 'CTRL' }
config.keys = {
    {
        key = 'h',
        mods = 'LEADER',
        action = wezterm.action.AdjustPaneSize { 'Left', 5 }
    },
    {
        key = 'l',
        mods = 'LEADER',
        action = wezterm.action.AdjustPaneSize { 'Right', 5 }
    },
    {
        key = 'j',
        mods = 'LEADER',
        action = wezterm.action.AdjustPaneSize { 'Down', 5 }
    },
    {
        key = 'k',
        mods = 'LEADER',
        action = wezterm.action.AdjustPaneSize { 'Up', 5 }
    },
}

return config