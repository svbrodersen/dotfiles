vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
  'https://github.com/igorlfs/nvim-dap-view',
  'https://github.com/leoluz/nvim-dap-go',
  'https://github.com/nvimtools/hydra.nvim',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',
}

require("mason").setup()

local dap = require 'dap'
local Hydra = require 'hydra'

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
-- FIXED: This should be an array of configurations
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

local dap = require 'dap'
require('dap-view').setup(opts)

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
        table.insert(keymap_restore, keymap)
        api.nvim_buf_del_keymap(buf, 'n', 'K')
      end
    end
  end
  api.nvim_set_keymap('n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

-- Define the Hydra used while debugging
local dap_hydra = Hydra {
  name = 'DAP Controls',
  mode = 'n',
  body = '<leader>dd', -- Manual trigger if you want it
  desc = 'hydra mapping',
  config = {
    color = 'pink',
    invoke_on_body = true,
    hint = {
      type = 'window',
      position = 'bottom',
    },
  },
  heads = {
    { 'n', dap.step_over, { silent = true } },
    { 'i', dap.step_into, { silent = true } },
    { 'o', dap.step_out, { silent = true } },
    { 'u', dap.up, { silent = true } },
    { 'd', dap.down, { silent = true } },
    { 'c', dap.continue, { silent = true } },
    { 'r', dap.run_to_cursor, { silent = true } },
    { 't', dap.toggle_breakpoint, { silent = true } },
    { 'x', dap.terminate, { exit = true, silent = true } },
    { 'q', nil, { exit = true } },
  },
}

-- Automatically enter debug-hydra when DAP starts
dap.listeners.after.event_initialized['dap_hydra'] = function()
  dap_hydra:activate()
end

-- Exit hydra when debugging terminates/exits
dap.listeners.before.event_terminated['dap_hydra'] = function()
  dap_hydra:exit()
end

dap.listeners.before.event_exited['dap_hydra'] = function()
  dap_hydra:exit()
end

-- Resize

Hydra {
  name = 'Resize Window',
  mode = 'n', -- normal mode
  body = 'g<C-w>', -- activate hydra after pressing Ctrl-w
  heads = {
    { 'h', '2<C-w><', { desc = 'Resize Left' } },
    { 'l', '2<C-w>>', { desc = 'Resize Right' } },
    { 'j', '2<C-w>+', { desc = 'Resize Down' } },
    { 'k', '2<C-w>-', { desc = 'Resize Up' } },
    { '<Esc>', nil, { exit = true, desc = 'Exit Hydra' } },
  },
  config = {
    invoke_on_body = true, -- allow activating hydra on body press
    hint = {
      type = 'window',
      position = 'bottom',
    },
  },
}

-- Keymaps

vim.keymap.set (
  "n",
  "<leader>dt",
  function()
    require('dap').toggle_breakpoint()
  end,
  { desc = 'Toggle breakpoint' }
)


vim.keymap.set (
  'n',
  '<leader>dc',
  function()
    require('dap').continue()
  end,
  { desc = 'Continue' }
)

vim.keymap.set(

  'n',
  '<leader>di',
  function()
    require('dap').step_into()
  end,
  { desc = 'Step Into' }
) 

vim.keymap.set (
  'n',
  '<leader>do',
  function()
    require('dap').step_over()
  end,
  { desc = 'Step Over' }
)

vim.keymap.set (
  'n',
  '<leader>dO',
  function()
    require('dap').step_out()
  end,
  { desc = 'Step Out' }
)

vim.keymap.set (
  'n',
  '<leader>db',
  function()
    require('dap').step_back()
  end,
  { desc = 'Step Back' }
)

vim.keymap.set (
  'n',
  '<leader>dr',
  function()
    require('dap').restart()
  end,
  { desc = 'Restart' }
)

