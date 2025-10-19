return {
  {
    'mrcjkb/haskell-tools.nvim',
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim', -- optional
      'mfussenegger/nvim-dap', -- Required for debugging
    },
  },
  {
    'mrcjkb/haskell-snippets.nvim',
    dependencies = { 'L3MON4D3/LuaSnip' },
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    config = function()
      local haskell_snippets = require('haskell-snippets').all
      require('luasnip').add_snippets('haskell', haskell_snippets, { key = 'haskell' })
    end,
  },
  {
    'luc-tielen/telescope_hoogle',
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      local ok, telescope = pcall(require, 'telescope')
      if ok then
        telescope.load_extension 'hoogle'
      end
    end,
  },
}
