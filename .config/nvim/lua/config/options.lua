-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.tw = 80
vim.o.wrap = true
vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50\z
                    ,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor\z
                    ,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.o.background = "dark"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.background = "dark"
vim.o.updatetime = 1000

vim.g.lazyvim_python_lsp = "pyright"

vim.filetype.add({ extension = { templ = "templ" } })
vim.lsp.set_log_level("debug")
