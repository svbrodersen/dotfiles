-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.tw = 80
vim.o.wrap = true
vim.opt.guicursor = {
  "n-v-c:block-Cursor/lCursor", -- Block cursor in normal, visual, and command modes
  "i:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- Blinking vertical line in insert mode
  "r-cr-o:hor20-Cursor/lCursor", -- Horizontal line cursor in replace, command-line replace, and operator-pending modes
}
vim.o.background = "dark"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.background = "dark"
vim.o.updatetime = 1000

vim.g.lazyvim_python_lsp = "pyright"

vim.filetype.add({ extension = { templ = "templ" } })
vim.lsp.set_log_level("debug")
