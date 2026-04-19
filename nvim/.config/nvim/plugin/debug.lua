vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
  'https://github.com/igorlfs/nvim-dap-view.git',
  'https://github.com/leoluz/nvim-dap-go',
"https://github.com/nvim-neotest/neotest.git",
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',
}

require('mason').setup()

local dap = require 'dap'
local dapview = require("dap-view")

local dap = require 'dap'
-- Setup mason-nvim-dap first
require('mason-nvim-dap').setup {
  automatic_installation = true,
  handlers = {},
  ensure_installed = {
    'delve',
    'codelldb',
  },
}

-- Setup language-specific adapters
require('dap-go').setup {
  delve = {
    detached = vim.fn.has 'win32' == 0,
  },
}

-- Configure C/C++/Rust debugging
dap.configurations.cpp = {
  {
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Change breakpoint icons
vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
local breakpoint_icons = vim.g.have_nerd_font
    and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
  or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
for type, icon in pairs(breakpoint_icons) do
  local tp = 'Dap' .. type
  local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
  vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

-- Set K to hover widgets
local api = vim.api
local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
  for _, buf in pairs(api.nvim_list_bufs()) do
    local keymaps = api.nvim_buf_get_keymap(buf, 'n')
    for _, keymap in pairs(keymaps) do
      if keymap.lhs == 'K' then
        -- Wrap the keymap and the buffer ID in a table
        table.insert(keymap_restore, { buf = buf, map = keymap })
        api.nvim_buf_del_keymap(buf, 'n', 'K')
      end
    end
  end
  api.nvim_set_keymap('n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after.event_initialized["dap_view"] = function()
  dapview.open()
end

-- close UI when session ends (normal termination)
dap.listeners.after.event_terminated["dap_view"] = function()
  dapview.close()
end

-- also close on exit (important for force stop / error cases)
dap.listeners.after.event_exited["dap_view"] = function()
  dapview.close()
end

dap.listeners.after['event_terminated']['me'] = function()
  -- Remove the global DAP 'K' mapping
  pcall(api.nvim_del_keymap, 'n', 'K')
  -- Restore the original 'K' mappings
  for _, restore in ipairs(keymap_restore) do
    pcall(api.nvim_buf_set_keymap, restore.buf, restore.map.mode, restore.map.lhs, restore.map.rhs, {
      silent = restore.map.silent == 1,
      noremap = restore.map.noremap == 1,
      desc = restore.map.desc,
    })
  end
  keymap_restore = {}
end

-- nvim-dap-view
require('dap-view').setup {
  winbar = {
    show_keymap_hints = true,
    controls = {
      enabled = true,
    },
  },
}

-- Keymaps
vim.keymap.set('n', '<F1>', function()
  require('dap').continue()
end, { desc = 'Continue' })
vim.keymap.set('n', '<F2>', function()
  require('dap').step_over()
end, { desc = 'Step Over' })
vim.keymap.set('n', '<F3>', function()
  require('dap').step_into()
end, { desc = 'Step Into' })
vim.keymap.set('n', '<F4>', function()
  require('dap').step_back()
end, { desc = 'Step Back' })
vim.keymap.set('n', '<F5>', function()
  require('dap').step_out()
end, { desc = 'Step Out' })
vim.keymap.set('n', '<F6>', function()
  require('dap').run_to_cursor()
end, { desc = 'Run to cursor' })

vim.keymap.set('n', '<leader>dt', function()
  require('dap').toggle_breakpoint()
end, { desc = 'Toggle breakpoint' })

vim.keymap.set('n', '<F10>', function()
  require('dap').toggle_breakpoint()
end, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<F11>', function()
  require('dap').restart()
end, { desc = 'Restart' })
vim.keymap.set('n', '<F12>', function()
  require('dap').terminate()
end, { desc = 'Restart' })
