return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = true,
  opts = {
    highlights = {
      current = "DiffText",
      incoming = "DiffAdd",
      ancestor = "DiffChange",
    },
  },
}
