vim.pack.add {
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/L3MON4D3/LuaSnip',
}

require("luasnip").setup()
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
require('luasnip.loaders.from_snipmate').load { paths = vim.fn.stdpath("config") .. "/snippets" }
require('luasnip.loaders.from_lua').lazy_load { paths = vim.fn.stdpath("config") .. "/snippets" }
