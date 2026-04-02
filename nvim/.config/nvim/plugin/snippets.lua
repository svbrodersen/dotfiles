vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'luasnip' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'luasnip'
      end
      vim.cmd 'make install_jsregexp'
    end
  end,
})

vim.pack.add {
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/L3MON4D3/LuaSnip',
}

require("luasnip").setup()
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
require('luasnip.loaders.from_snipmate').load { paths = vim.fn.stdpath("config") .. "/snippets" }
require('luasnip.loaders.from_lua').lazy_load { paths = vim.fn.stdpath("config") .. "/snippets" }
