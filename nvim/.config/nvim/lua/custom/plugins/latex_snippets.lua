return {
  'iurimateus/luasnip-latex-snippets.nvim',
  dependencies = { 'L3MON4D3/LuaSnip' },
  config = function()
    local luasnip = require 'luasnip'
    luasnip.config.setup { enable_autosnippets = true }

    require('luasnip-latex-snippets').setup {
      {
        use_treesitter = true,
        allow_on_markdown = true,
      },
    }
  end,
}
