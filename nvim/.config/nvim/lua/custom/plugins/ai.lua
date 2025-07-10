return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'BufReadPost',
    opts = {
      suggestion = {
        enabled = false,
        hide_during_completion = true,
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      { '<leader>a', mode = { 'v', 'n' }, desc = '[A]i' },
      { '<leader>ac', '<cmd>CodeCompanionChat<cr>', mode = { 'v', 'n' }, desc = 'Ai [C]hat' },
      { '<leader>ae', "<cmd>'<,'>CodeCompanion /explain<cr>", mode = 'v', desc = 'Ai [E]xplain' },
      { '<leader>at', "<cmd>'<,'>CodeCompanion /tests<cr>", mode = 'v', desc = 'Ai [T]ests' },
      { '<leader>af', "<cmd>'<,'>CodeCompanion /fix<cr>", mode = 'v', desc = 'Ai [F]ix' },
      { '<leader>ap', "<cmd>'<,'>CodeCompanion /lsp<cr>", mode = 'v', desc = 'Ai [l]sp explain' },
    },
    opts = {},
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion' },
  },
  {
    'echasnovski/mini.diff',
    config = function()
      local diff = require 'mini.diff'
      diff.setup {
        -- Disabled by default
        source = diff.gen_source.none(),
      }
    end,
  },
}
