vim.pack.add {
  'https://github.com/swaits/zellij-nav.nvim',
}

require("zellij-nav").setup()

vim.keymap.set (
  'n',
  '<c-h>',
  '<cmd>ZellijNavigateLeftTab<cr>',
  { silent = true, desc = 'Navigate Left' }
)

vim.keymap.set (
  'n',
  '<c-j>',
  '<cmd>ZellijNavigateDown<cr>',
  { silent = true, desc = 'Navigate Down' }
)

vim.keymap.set (
  'n',
  '<c-k>',
  '<cmd>ZellijNavigateUp<cr>',
  { silent = true, desc = 'Navigate Up' }
)

vim.keymap.set (
  'n',
  '<c-l>',
  '<cmd>ZellijNavigateRightTab<cr>',
  { silent = true, desc = 'Navigate Right' }
)
