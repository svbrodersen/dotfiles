-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {

      -- Required dependency for nvim-dap-ui
      'theHamsta/nvim-dap-virtual-text',

      -- Installs the debug adapters for you
      'mason-org/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
    },
    keys = {
      {
        '<leader>d',
        desc = 'Debug',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'toggle breakpoint',
      },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      local Hydra = require 'hydra'

      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {
          function(config)
            require('mason-nvim-dap').default_setup(config)
          end,
        },

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'delve',
          'cppdbg',
        },
      }

      dap.configurations = {
        c = {
          {
            name = 'Launch file',
            type = 'cppdbg',
            request = 'launch',
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = false,
            MIMode = 'lldb',
          },
          {
            name = 'Attach to lldbserver :1234',
            type = 'cppdbg',
            request = 'launch',
            MIMode = 'lldb',
            miDebuggerServerAddress = 'localhost:1234',
            miDebuggerPath = '/usr/bin/lldb',
            cwd = '${workspaceFolder}',
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
          },
        },
      }
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
    'rcarriga/nvim-dap-ui',
    config = function()
      local ui = require 'dapui'
      local dap = require 'dap'
      ui.setup()

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

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
    opts = {},
    keys = {
      {
        '<leader>du',
        function()
          require('dapui').toggle()
        end,
        desc = 'Debug: Dap UI',
        mode = 'n',
      },
      {
        '<leader>dw',
        function()
          require('dapui').elements.watches.add(vim.fn.expand '<cword>')
        end,
        desc = 'Add word under cursor to watches',
        mode = { 'n', 'v' }, -- FIXED
      },
      {
        '<leader>dW',
        function()
          require('dapui').elements.watches.add()
        end,
        desc = 'Add empty watch',
        mode = 'n',
      },
    },
    dependencies = {
      'jay-babu/mason-nvim-dap.nvim',
      'leoluz/nvim-dap-go',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
    },
  },
  {
    'leoluz/nvim-dap-go',
    opts = {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    },
    keys = {
      {
        '<leader>dt',
        function()
          require('dap-go').debug_test()
        end,
        desc = 'Debug: Test',
      },
      {
        '<leader>dl',
        function()
          require('dap-go').debug_last_test()
        end,
        desc = 'Debug: Last Test',
      },
    },
  },
}
