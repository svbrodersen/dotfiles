vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'copilot' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'copilot'
      end
      vim.cmd 'Copilot auth'
    end
  end,
})

vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://www.github.com/olimorris/codecompanion.nvim',
}

require('copilot').setup {
  suggestion = {
    enabled = false,
    hide_during_completion = true,
  },
  panel = { enabled = false },
  filetypes = {
    markdown = true,
    help = true,
  },
}
require('render-markdown').setup()

require('codecompanion').setup {
  interactions = {
    chat = {
      adapter = 'opencode',
    },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>ac', '<cmd>CodeCompanionChat<cr>', { desc = 'Chat' })
vim.keymap.set('v', '<leader>at', "<cmd>'<,'>CodeCompanion /tests<cr>", { desc = 'Toggle' })
vim.keymap.set('v', '<leader>ae', "<cmd>'<,'>CodeCompanion /explain<cr>", { desc = 'Explain' })
vim.keymap.set('v', '<leader>aT', "<cmd>'<,'>CodeCompanion /tests<cr>", { desc = 'Test' })
vim.keymap.set('v', '<leader>af', "<cmd>'<,'>CodeCompanion /fix<cr>", { desc = 'Fix' })
