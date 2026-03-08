return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
  lazy = false,
  config = function(_, opts)
    require('oil').setup(opts)

    vim.keymap.set('n', '<leader>e', function()
      if vim.t.is_codediff then
        return
      end
      vim.cmd 'Oil'
    end, { desc = 'Open oil in current dir' })
  end,
}
