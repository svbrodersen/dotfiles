return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = true,
  opts = {
    default_mappings = {
      ours = "<leader>co",
      theirs = "<leader>ct",
      none = "<leader>c0",
      both = "<leader>cb",
      next = "]x",
      prev = "[x",
    },
  },
}
