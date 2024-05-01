return {
  "kkoomen/vim-doge",
  build = ":call doge#install()",
  init = function()
    vim.g.doge_doc_standard_python = "numpy"
    vim.g.doge_filetype_aliases = {
      python = { "cython", ".pyx" },
    }
    vim.g.doge_enable_mappings = 0
  end,
}
