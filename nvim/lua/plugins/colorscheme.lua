return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavous = "frappe",
      transparent_background = true,
      integrations = {
        notify = true,
      },
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
    opts = {
      transparent_mode = true,
    },
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
