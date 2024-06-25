return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = true,
  opts = {
    highlights = {
      incoming = "DiffAdd",
      current = "DiffText",
      ancestor = "DiffChange",
    },
  },
}
