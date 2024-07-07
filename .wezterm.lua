-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Kanagawa Dragon (Gogh)"
config.colors = {
	background = "#141414",
}
config.font = wezterm.font({
	family = "FiraCode Nerd Font",
	weight = "Medium",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.bold_brightens_ansi_colors = "No"
config.window_background_opacity = 0.9
config.font_size = 12
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
-- and finally, return the configuration to wezterm
return config
