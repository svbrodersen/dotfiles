return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/snippets/" })
    require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })
  end,
}
