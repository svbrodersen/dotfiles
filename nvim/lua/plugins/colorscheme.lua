local base = {
  red = "#ff657a",
  maroon = "#F29BA7",
  peach = "#ff9b5e",
  yellow = "#eccc81",
  green = "#a8be81",
  teal = "#9cd1bb",
  sky = "#A6C9E5",
  sapphire = "#86AACC",
  blue = "#5d81ab",
  lavender = "#66729C",
  mauve = "#b18eab",
}

local extend_base = function(value)
  return vim.tbl_extend("force", base, value)
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      flavour = "mocha",
    },
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      transparent = true,
      theme = "dragon",
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    config = true,
    priority = 1000,
    setup = true,
    opts = function()
      local colors = require("gruvbox").palette
      return {
        transparent_mode = true,
        overrides = {
          Cursor = { fg = colors.bright_orange, bg = colors.dark0 },
        },
        inverse = false,
      }
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
