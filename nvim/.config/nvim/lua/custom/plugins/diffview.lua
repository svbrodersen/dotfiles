return {
  'sindrets/diffview.nvim',
  config = true,
  opts = {
    view = {
      merge_tool = {
        layout = 'diff3_mixed',
        winbar_info = true,
      },
      default = {
        layout = 'diff2_horizontal',
      },
    },
  },
}
