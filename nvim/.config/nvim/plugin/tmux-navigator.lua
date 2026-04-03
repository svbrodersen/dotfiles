vim.pack.add ({
  "https://github.com/christoomey/vim-tmux-navigator.git",}
)

vim.keymap.set (
  'n',
  '<c-h>',
  '<cmd>TmuxNavigateLeft<cr>',
  { silent = true, desc = 'Navigate Left' }
)

vim.keymap.set (
  'n',
  '<c-j>',
  '<cmd>TmuxNavigateDown<cr>',
  { silent = true, desc = 'Navigate Down' }
)

vim.keymap.set (
  'n',
  '<c-k>',
  '<cmd>TmuxNavigateUp<cr>',
  { silent = true, desc = 'Navigate Up' }
)

vim.keymap.set (
  'n',
  '<c-l>',
  '<cmd>TmuxNavigateRight<cr>',
  { silent = true, desc = 'Navigate Right' }
)
