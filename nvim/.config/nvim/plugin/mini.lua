vim.pack.add {
  'https://github.com/echasnovski/mini.nvim',
}

require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.sessions').setup({

})

require('mini.statusline').setup {
  use_icons = vim.g.have_nerd_font,
}

vim.keymap.set (
  "n",
  "<leader>rs",
  function ()
    require("mini.sessions").select()
  end,
  {desc = "Session"}
)

vim.keymap.set (
  "n",
  "<leader>rd",
  function ()
    require("mini.sessions").select("delete")
  end,
  {desc = "Session"}
)

vim.keymap.set (
  "n",
  "<leader>rw",
  function ()
    require("mini.sessions").write()
  end,
  {desc = "Write session"}
)

vim.keymap.set (
  "n",
  "<leader>rc",
  function ()
    local input = vim.fn.input("Name: ")
    require("mini.sessions").write(input)
  end,
  {desc = "Create session"}
)

vim.keymap.set (
  "n",
  "<leader>rl",
  function ()
    require("mini.sessions").read()
  end,
  {desc = "Last"}
)
