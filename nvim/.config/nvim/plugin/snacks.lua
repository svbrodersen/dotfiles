vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/folke/snacks.nvim',
}

local Snacks = require("snacks")

Snacks.setup({
    bigfile = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    words = { enabled = true },
    icons = { enabled = true },
})

vim.keymap.set("n", '<leader><space>', function ()
  Snacks.picker.smart({
      layout = {preset = "default", preview = false}
  })
end, {desc = 'Smart Find Files'})

vim.keymap.set("n", '<leader>,', function ()
  Snacks.picker.buffers()
end, {desc = 'Buffers'})

vim.keymap.set("n", '<leader>/', function ()
  Snacks.picker.grep()
end, {desc = 'Grep'})

vim.keymap.set("n", '<leader>:', function ()
  Snacks.picker.command_history()
end, {desc = 'Command History'})

-- Search

vim.keymap.set("n", '<leader>st', function ()
  Snacks.picker.todo_comments()
end, {desc = 'Find Todo'})

vim.keymap.set("n", '<leader>sb', function ()
  Snacks.picker.grep_buffers()
end, {desc = 'Grep Buffers'})

vim.keymap.set("n", '<leader>sw', function ()
  Snacks.picker.grep_word()
end, {desc = 'Grep Word'})

vim.keymap.set("n", '<leader>sk', function ()
  Snacks.picker.keymaps()
end, {desc = 'Keymaps'})

vim.keymap.set("n", '<leader>sm', function ()
  Snacks.picker.marks()
end, {desc = 'Marks'})

vim.keymap.set("n", '<leader>sq', function ()
  Snacks.picker.qflist()
end, {desc = 'Quickfix List'})

-- Git

vim.keymap.set("n", '<leader>gl', function ()
  Snacks.picker.git_log_line()
end, {desc = 'Git Log Line'})

vim.keymap.set("n", '<leader>gg', function ()
  Snacks.lazygit()
end, {desc = 'Lazygit'})

-- UI

vim.keymap.set("n", '<leader>uC', function ()
  Snacks.picker.colorschemes()
end, {desc = 'Colorschemes'})

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    -- Setup some globals for debugging (lazy-loaded)
    _G.dd = function(...)
      Snacks.debug.inspect(...)
    end
    _G.bt = function()
      Snacks.debug.backtrace()
    end
    vim.print = _G.dd -- Override print to use snacks for `:=` command

    -- Create some toggle mappings
    Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
    Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
    Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
    Snacks.toggle.diagnostics():map '<leader>ud'
    Snacks.toggle.line_number():map '<leader>ul'
    Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
    Snacks.toggle.treesitter():map '<leader>uT'
    Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
    Snacks.toggle.inlay_hints():map '<leader>uh'
  end,
})
