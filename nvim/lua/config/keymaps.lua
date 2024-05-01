-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local tele_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fg", tele_builtin.live_grep, { desc = "live grep" })
