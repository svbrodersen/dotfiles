vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
  'https://github.com/igorlfs/nvim-dap-view.git',
  'https://github.com/leoluz/nvim-dap-go',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',

  'https://github.com/nvim-neotest/nvim-nio.git',
  'https://github.com/nvim-neotest/neotest.git',
  'https://github.com/fredrikaverpil/neotest-golang',
  'https://github.com/rouge8/neotest-rust',
}

require('mason').setup()

local dap = require 'dap'
local dapview = require 'dap-view'

-- Setup mason-nvim-dap first
require('mason-nvim-dap').setup {
  automatic_installation = true,
  handlers = {},
  ensure_installed = {
    'delve',
    'codelldb',
  },
}

local mason_bin = vim.fn.stdpath 'data' .. '/mason/'
local codelldb_path = mason_bin .. 'bin/codelldb'
local liblldb_path = mason_bin .. 'packages/codelldb/extension/lldb/lib/liblldb'
local os_name = io.popen('uname'):read '*l'

if os_name == 'Darwin' then
  liblldb_path = liblldb_path .. '.dylib'
elseif os_name == 'Linux' then
  liblldb_path = liblldb_path .. '.so'
else -- Windows setup
  codelldb_path = mason_bin .. 'packages\\codelldb\\extension\\adapter\\codelldb.exe'
  liblldb_path = mason_bin .. 'packages\\codelldb\\extension\\lldb\\bin\\liblldb.dll'
end

-- Define the codelldb adapter for nvim-dap
-- The --liblldb argument is critical; without it, Rust types (Strings, Vecs) won't format properly.
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = codelldb_path,
    args = { '--port', '${port}', '--liblldb', liblldb_path },
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
      -- Targets standard Rust target folder location alongside fallback
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
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
        table.insert(keymap_restore, { buf = buf, map = keymap })
        api.nvim_buf_del_keymap(buf, 'n', 'K')
      end
    end
  end
  api.nvim_set_keymap('n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after.event_initialized['dap_view'] = function()
  dapview.open()
end

dap.listeners.after.event_terminated['dap_view'] = function()
  dapview.close()
end

dap.listeners.after.event_exited['dap_view'] = function()
  dapview.close()
end

dap.listeners.after['event_terminated']['me'] = function()
  pcall(api.nvim_del_keymap, 'n', 'K')
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
vim.keymap.set('n', '<F1>', dap.continue, { desc = 'Continue' })
vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Step Over' })
vim.keymap.set('n', '<F3>', dap.step_into, { desc = 'Step Into' })
vim.keymap.set('n', '<F4>', dap.step_back, { desc = 'Step Back' })
vim.keymap.set('n', '<F5>', dap.step_out, { desc = 'Step Out' })
vim.keymap.set('n', '<F6>', dap.run_to_cursor, { desc = 'Run to cursor' })
vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<F10>', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<F11>', dap.restart, { desc = 'Restart' })
vim.keymap.set('n', '<F12>', dap.terminate, { desc = 'Terminate' })

-- Neotest
require('neotest').setup {
  adapters = {
    require 'neotest-rust' {
      args = { '--no-capture' },
    },

    require 'neotest-golang' {
      go_test_args = { '-v', '-race', '-count=1', '-timeout=60s' },
      dap_go_enabled = true, -- Smoothly hooks into your existing delve configurations
    },
  },
}

-- Map a shortcut to debug the nearest test contextually
vim.keymap.set('n', '<leader>td', function()
  require('neotest').run.run { strategy = 'dap' }
end, { desc = 'Debug Nearest Test' })
