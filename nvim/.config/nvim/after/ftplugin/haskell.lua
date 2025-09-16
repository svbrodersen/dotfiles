local ht = require 'haskell-tools'
local bufnr = vim.api.nvim_get_current_buf()
local base_opts = { noremap = true, silent = true, buffer = bufnr }

-- Helper to extend base_opts with a description
local function with_desc(desc)
  local o = vim.tbl_extend('force', base_opts, { desc = desc })
  return o
end

-- Run LSP CodeLens actions (e.g., run tests, generate code)
vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, with_desc 'Run CodeLens actions')

-- Hoogle: lookup type signature of the symbol under the cursor
vim.keymap.set('n', '<space>cs', ht.hoogle.hoogle_signature, with_desc 'Hoogle: show type signature')

-- Evaluate all code snippets in the current buffer
vim.keymap.set('n', '<space>ce', ht.lsp.buf_eval_all, with_desc 'Evaluate all code snippets')

-- Toggle a GHCi REPL for the current package
vim.keymap.set('n', '<leader>cR', ht.repl.toggle, with_desc 'Toggle GHCi REPL (package)')

-- Toggle a GHCi REPL for the current file
vim.keymap.set('n', '<leader>cF', function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, with_desc 'Toggle GHCi REPL (current file)')

-- Quit the currently running GHCi REPL
vim.keymap.set('n', '<leader>cq', ht.repl.quit, with_desc 'Quit GHCi REPL')
