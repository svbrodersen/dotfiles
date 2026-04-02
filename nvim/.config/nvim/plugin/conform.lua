vim.pack.add {
  'https://github.com/stevearc/conform.nvim',
}

require('conform').setup {
  notify_on_error = false,
  format_on_save = nil,
  formatters = {
    futhark_fmt = {
      command = 'futhark',
      args = { 'fmt', '$FILENAME' },
      stdin = false,
    },
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    fut = { 'futhark_fmt' },
    json = { 'prettierd', 'prettier', stop_after_first = true },
  },
}

vim.keymap.set({'n', 'v'}, '<leader>cf', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Format' })
