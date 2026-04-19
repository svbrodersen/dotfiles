vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
}

local function dap_status()
  local ok, dap = pcall(require, 'dap')
  if not ok or dap.session() == nil then
    return ''
  end
  local symbols = {
      continue = "F1: Continue",
      step_over = "F2: Over",
      step_into = "F3: Into",
      step_back = "F4: Back",
      step_out = "F4: Out",
    }
  return string.format('%s - %s - %s - %s - %s', symbols.continue, symbols.step_over, symbols.step_into, symbols.step_back, symbols.step_out)
end

require('lualine').setup {
  options = {
    theme = 'auto',
    globalstatus = true, -- Highly recommended for DAP setups
  },
  sections = {
    lualine_c = {
      'filename',
      {
        dap_status,
        color = { fg = '#ff9e64', gui = 'bold' }, -- A distinct color for debugging
      },
    },
    -- ... your other sections
  },
}
