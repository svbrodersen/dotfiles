vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim.git',
  'https://github.com/nvim-neotest/neotest',
  'https://github.com/rouge8/neotest-rust.git',
  'https://github.com/nvim-neotest/neotest-go',
  'https://github.com/nvim-neotest/nvim-nio',
}

local neotest = require 'neotest'

neotest.setup {
  adapters = {
    require("neotest-go") {
    },
    require("neotest-rust") {
    },
  },
  status = { virtual_text = true },
  output = { open_on_run = true },
  quickfix = {
    open = function()
      if LazyVim.has("trouble.nvim") then
        require("trouble").open({ mode = "quickfix", focus = false })
      else
        vim.cmd("copen")
      end
    end,
  },
}

local function keymap(mapping, func, desc)
  vim.keymap.set('n', mapping, func, { desc = desc })
end

keymap('<leader>tr', function()
  neotest.run.run()
end, 'Run test')

keymap('<leader>tf', function()
  neotest.run.run(vim.fn.expand '%')
end, 'Run file tests')

keymap('<leader>td', function()
  neotest.run.run( { strategy = 'dap' })
end, 'Debug test')

keymap('<leader>tl', function()
  neotest.run.run_last()
end, 'Run last')

keymap('<leader>tt', function()
  neotest.output_panel.toggle() { strategy = 'dap' }
end, 'Toggle output')
