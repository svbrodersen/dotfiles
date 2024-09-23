return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = true,
  opts = {
    default_mappings = {
      ours = "co",
      theirs = "ct",
      none = "c0",
      both = "cb",
      next = "]x",
      prev = "[x",
    },
  },
}
