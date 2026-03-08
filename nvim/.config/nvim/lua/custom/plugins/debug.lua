-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well.
--

local function make_repeatable(action_name, action_fn)
  return function()
    -- Create a global wrapper for the action
    _G[action_name] = function()
      action_fn()
    end

    -- Set the operatorfunc to call that wrapper
    vim.go.operatorfunc = 'v:lua.' .. action_name

    -- Execute 'g@l' (call operator on current char)
    -- This records the action so '.' can repeat it
    vim.cmd.normal { 'g@l', bang = true }
  end
end

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'mason-org/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'leoluz/nvim-dap-go',
    },
    keys = {
      {
        '<leader>d',
        desc = 'Debug',
      },
      {
        '<leader>dt',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle breakpoint',
      },
      {
        '<leader>dc',
        function()
          local dap = require 'dap'
          make_repeatable('dap_continue', dap.continue)
        end,
        desc = 'Continue',
      },
      {
        '<leader>di',
        function()
          local dap = require 'dap'
          make_repeatable('dap_step_into', dap.step_into)
        end,
        desc = 'Step Into',
      },
      {
        '<leader>do',
        function()
          local dap = require 'dap'
          make_repeatable('dap_step_over', dap.step_over)
        end,
        desc = 'Step Over',
      },
      {
        '<leader>dO',
        function()
          local dap = require 'dap'
          make_repeatable('dap_step_out', dap.step_out)
        end,
        desc = 'Step Out',
      },
      {
        '<leader>db',
        function()
          local dap = require 'dap'
          make_repeatable('dap_step_back', dap.step_back)
        end,
        desc = 'Step Back',
      },
      {
        '<leader>dr',
        function()
          require('dap').restart()
        end,
        desc = 'Restart',
      },
    },
    config = function()
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
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = true,
    dependencies = {
      'mfussenegger/nvim-dap',
    },
  },
  {
    'igorlfs/nvim-dap-view',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    opts = {
      -- Automatically open/close the view when debugging starts/stops
      auto_toggle = true,
    },
    config = function(_, opts)
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
    end,
    keys = {
      {
        '<leader>du',
        function()
          require('dap-view').toggle()
        end,
        desc = 'Debug: Toggle Dap View',
        mode = 'n',
      },
      {
        '<leader>dw',
        function()
          require('dap-view').add_expr(vim.fn.expand '<cword>')
        end,
        desc = 'Add word under cursor to watches',
        mode = { 'n', 'v' },
      },
      {
        '<leader>dW',
        function()
          require('dap-view').add_expr()
        end,
        desc = 'Add empty watch',
        mode = 'n',
      },
    },
  },
  {
    'leoluz/nvim-dap-go',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    ft = 'go',
    keys = {
      {
        '<leader>dT',
        function()
          require('dap-go').debug_test()
        end,
        desc = 'Debug Go Test',
        ft = 'go',
      },
      {
        '<leader>dl',
        function()
          require('dap-go').debug_last_test()
        end,
        desc = 'Debug Last Go Test',
        ft = 'go',
      },
    },
  },
}
