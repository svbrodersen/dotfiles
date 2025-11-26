return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
  lazy = false,
  keys = {
    { '<leader>e', '<cmd>Oil<cr>', desc = 'Open oil in current dir' },
  },
}
