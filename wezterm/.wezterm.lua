-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This holds teh configuration
local config = wezterm.config_builder()

-- Config
config.color_scheme = 'catppuccin-mocha'
config.window_background_opacity = 0.6
config.text_background_opacity = 0.7

config.leader = { key = ' ', mods = 'SHIFT' }
config.disable_default_key_bindings = true
config.keys = {
    {
        key = "D",
        mods = 'LEADER',
        action = wezterm.action.ShowDebugOverlay
    },
    {
        key = "P",
        mods = 'LEADER',
        action = wezterm.action.ActivateCommandPalette
    },
    {
        key = '%',
        mods = 'LEADER',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    {
        key = '\'',
        mods = 'LEADER',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    {
        key = 'H',
        mods = 'LEADER',
        action = wezterm.action { ActivatePaneDirection = 'Left' }
    },
    {
        key = 'J',
        mods = 'LEADER',
        action = wezterm.action { ActivatePaneDirection = 'Down' }
    },
    {
        key = 'K',
        mods = 'LEADER',
        action = wezterm.action { ActivatePaneDirection = 'Up' }
    },
    {
        key = 'L',
        mods = 'LEADER',
        action = wezterm.action { ActivatePaneDirection = 'Right' }
    },
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
