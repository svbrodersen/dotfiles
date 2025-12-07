return {
  'nvimtools/hydra.nvim',
  config = function()
    local dap = require 'dap'
    local Hydra = require 'hydra'

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
        { 'h', '5<C-w><', { desc = 'Resize Left' } },
        { 'l', '5<C-w>>', { desc = 'Resize Right' } },
        { 'j', '5<C-w>+', { desc = 'Resize Down' } },
        { 'k', '5<C-w>-', { desc = 'Resize Up' } },
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
  end,
}
