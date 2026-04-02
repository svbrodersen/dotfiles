return {
  "kkoomen/vim-doge",
  build = ":call doge#install()", -- important!
  config = function()
    -- Disable default mappings (recommended)
    vim.g.doge_enable_mappings = 0

    -- Map <leader>D to generate documentation
    vim.keymap.set("n", "<leader>D", "<Plug>(doge-generate)", {
      silent = true,
      desc = "Generate documentation (vim-doge)",
    })

    -- Optional: jump between TODO fields in generated docs
    vim.keymap.set("n", "<Tab>", "<Plug>(doge-comment-jump-forward)")
    vim.keymap.set("n", "<S-Tab>", "<Plug>(doge-comment-jump-backward)")
  end,
}
