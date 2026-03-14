-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'Gruvbox Material (Gogh)'
config.colors = {
	background = "#111111",
}
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"
config.enable_kitty_graphics = true
config.max_fps = 120

config.keys = {
  -- Equivalent to `close_tab:this`
  {
    key = 'x',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },

  -- Equivalent to `next_tab`
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(1),
  },

  -- Equivalent to `previous_tab`
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(-1),
  },

  {
    key = 'Enter',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ToggleFullScreen,
  },
}

return config
