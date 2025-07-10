-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.enable_wayland = false

config.color_scheme = "GruvboxDarkHard"
config.colors = {
	background = "#141414",
}
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Fira Code",
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.bold_brightens_ansi_colors = "No"
config.font_size = 12
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"

config.term = "wezterm"
config.enable_kitty_graphics = true
config.max_fps = 120

config.keys = {
	{
		key = "f",
		mods = "CTRL | ALT",
		action = wezterm.action.ToggleFullScreen,
	},
}

return config
