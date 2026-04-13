vim.pack.add{
  "https://github.com/nvim-pack/nvim-spectre"
}

vim.keymap.set('n', '<leader>sr', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Replace"
})

vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Replace Word"
})
