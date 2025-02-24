return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {
      palette_overrides = {
        dark0 = "#141414",
        dark1 = "#141414",
        light0 = "#ebdbb2",
        light1 = "#d5c4a1",
        light2 = "#bdae93",
        light3 = "#a89984",
        bright_green = "#b0b846",
        bright_red = "#f2594b",
        bright_yellow = "#e9b143",
        bright_purple = "#d3869b",
        bright_blue = "#80aa9e",
        bright_aqua = "#8bba7f",
        bright_orange = "#f28534",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
