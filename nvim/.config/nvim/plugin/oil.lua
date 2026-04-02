vim.pack.add({
  'https://github.com/stevearc/oil.nvim',
})

require("oil").setup({
  use_default_keymaps = false,
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<A-s>"] = { "actions.select", opts = { vertical = true } },
    ["<-h>"] = { "actions.select", opts = { horizontal = true } },
    ["<A-t>"] = { "actions.select", opts = { tab = true } },
    ["<A-p>"] = "actions.preview",
    ["<A-c>"] = { "actions.close", mode = "n" },
    ["<A-l>"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["`"] = { "actions.cd", mode = "n" },
    ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
  },
})


vim.keymap.set('n', '<leader>e', function()
  if vim.t.is_codediff then
    return
  end
  vim.cmd 'Oil'
end, { desc = 'Open oil in current dir' })
