return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      local bg_color = os.getenv 'BACKGROUND_COLOR'
      require('gruvbox').setup {
        palette_overrides = {
          dark0 = bg_color,
          dark1 = bg_color,
          light0 = '#ebdbb2',
          light1 = '#d5c4a1',
          light2 = '#bdae93',
          light3 = '#a89984',
          bright_green = '#b0b846',
          bright_red = '#f2594b',
          bright_yellow = '#e9b143',
          bright_purple = '#d3869b',
          bright_blue = '#80aa9e',
          bright_aqua = '#8bba7f',
          bright_orange = '#f28534',
        },
        overrides = {
          DiffAdd = { bg = '#32361a' },
          DiffChange = { bg = '#222e2a' },
          DiffDelete = { bg = '#3c1f1e' },
          DiffText = { bg = '#3b2b0c', fg = '#ebdbb2' },
        },
      }
      vim.cmd 'colorscheme gruvbox'
    end,
  },
}
