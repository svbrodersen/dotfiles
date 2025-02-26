-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- Diff setup keymaps
vim.keymap.set({ "n", "i", "v" }, "<leader>go", "<cmd>diffget LO<cr>", { desc = "Diffget Ours" })
vim.keymap.set({ "n", "i", "v" }, "<leader>gt", "<cmd>diffget RE<cr>", { desc = "Diffget Theirs" })
vim.keymap.set({ "n", "i", "v" }, "<leader>g0", "<cmd>diffget BA<cr>", { desc = "Diffget Base" })
