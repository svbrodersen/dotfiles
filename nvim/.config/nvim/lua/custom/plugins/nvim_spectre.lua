return {
  'nvim-pack/nvim-spectre',
  keys = {
    { '<leader>sr', "<cmd>lua require('spectre').toggle()<CR>", mode = { 'n' }, { desc = 'Search Replace' } },
  },
  config = function()
    require('spectre').setup { is_block_ui_break = true }
  end,
}
