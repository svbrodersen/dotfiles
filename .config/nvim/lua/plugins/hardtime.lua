return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  lazy = false,
  opts = {},
  keys = {
    { "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"' },
    { "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"' },
  },
}
