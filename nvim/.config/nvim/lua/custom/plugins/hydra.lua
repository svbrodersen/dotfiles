return {
  'nvimtools/hydra.nvim',
  config = function()
    local dap = require 'dap'
    local Hydra = require 'hydra'

    -- Define the Hydra used while debugging
    local dap_hydra = Hydra({
      name = 'DAP Controls',
      mode = 'n',
      body = '<leader>dd',  -- Manual trigger if you want it
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
        { 'c', dap.continue, { silent = true } },
        { 'r', dap.run_to_cursor, { silent = true } },
        { 'b', dap.toggle_breakpoint, { silent = true } },
        { 'x', dap.terminate, { exit = true, silent = true } },
        { 'q', nil, { exit = true } },
      }
    })

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
  end
}
