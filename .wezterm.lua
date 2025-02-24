-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "GruvboxDarkHard"
config.colors = {
	background = "#141414",
}
config.font = wezterm.font_with_fallback({
	family = "FiraCode Nerd Font",
	weight = "Medium",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.bold_brightens_ansi_colors = "No"
config.font_size = 12
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
-- and finally, return the configuration to wezterm
--
config.term = "wezterm"
config.enable_kitty_graphics = true
config.max_fps = 120

config.keys = {
	{
		key = "f",
		mods = "ALT",
		action = wezterm.action.ToggleFullScreen,
	},
}

return config
