-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well.

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
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
          require('dap').continue()
        end,
        desc = 'Continue',
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        desc = 'Step Into',
      },
      {
        '<leader>do',
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<leader>dO',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<leader>db',
        function()
          require('dap').step_back()
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
