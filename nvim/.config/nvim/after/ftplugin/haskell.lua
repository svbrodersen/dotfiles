local ht = require 'haskell-tools'
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }

vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)
vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
vim.keymap.set('n', '<leader>rf', function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)
vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)


local haskell_reload_group = vim.api.nvim_create_augroup('HaskellReloadGroup', { clear = true })

-- Find an open Neovim terminal running ghci, return job id
local function find_ghci_term()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "terminal" then
      local chan = vim.b[buf].terminal_job_id
      if chan then
        local ok, info = pcall(vim.fn.jobinfo, chan)
        if ok and info and info.cmd then
          local cmdline = table.concat(info.cmd, " ")
          -- Match plain ghci, or cabal repl, or stack ghci:
          if cmdline:match("ghci") or cmdline:match("cabal.*repl") or cmdline:match("stack.*ghci") then
            return chan
          end
        end
      end
    end
  end
  return nil
end

vim.api.nvim_create_autocmd("BufWritePost", {
  group = haskell_reload_group,
  pattern = "*.hs",
  callback = function()
    local chan = find_ghci_term()
    if not chan then return end

    -- Reload all modules
    vim.fn.chansend(chan, ":r\n")
  end,
})
