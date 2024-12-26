-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This holds teh configuration
local config = wezterm.config_builder()

-- Config
config.color_scheme = 'catppuccin-mocha'
config.window_background_opacity = 0.6
config.text_background_opacity = 0.6

return config
