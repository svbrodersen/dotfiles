return {
  "PatrBal/vim-textidote",
  init = function()
    vim.g.textidote_jar = "~/textidote.jar"
  end,
  keys = {
    { "<localLeader>t", ":TeXtidoteToggle<CR>", desc = "Toggle textidote", mode = "n", ft = { "bib", "tex" } },
  },
}
