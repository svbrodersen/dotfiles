-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Don't create a new comment after using o in normal mode
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove("o")
  end,
})

vim.api.nvim_create_autocmd("DiffUpdated", {
  pattern = "*",
  callback = function()
    vim.notify(vim.opt.diff:get())
    if vim.opt.diff:get() then
      vim.keymap.set("n", "gl", ":diffget LO<CR>", {
        buffer = true,
        desc = "Diffget LO",
      })

      vim.keymap.set("n", "gr", ":diffget RE<CR>", {
        buffer = true,
        desc = "Diffget RE",
      })

      vim.keymap.set("n", "gb", function()
        vim.cmd("diffget LO | diffget RE")
      end, {
        buffer = true,
        desc = "Diffget BOTH",
      })
    end
  end,
})
