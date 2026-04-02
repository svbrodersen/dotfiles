vim.pack.add({
    'https://github.com/echasnovski/mini.nvim',
})

require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()

local statusline = require 'mini.statusline'
-- set use_icons to true if you have a Nerd Font
statusline.setup { use_icons = vim.g.have_nerd_font }
