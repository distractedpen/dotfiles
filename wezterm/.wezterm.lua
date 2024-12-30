-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This holds teh configuration
local config = wezterm.config_builder()

-- Config
config.color_scheme = 'catppuccin-mocha'
config.window_background_opacity = 0.6
config.text_background_opacity = 0.6

-- update arrow key keybinds to hjkl
config.keys = {
    {
        key = 'h',
        mods = 'CTRL|ALT|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Left', 5 }
    },
    {
        key = 'l',
        mods = 'CTRL|ALT|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Right', 5 }
    },
    {
        key = 'j',
        mods = 'CTRL|ALT|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Down', 5 }
    },
    {
        key = 'k',
        mods = 'CTRL|ALT|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Up', 5 }
    },
}

return config
