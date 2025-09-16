return {
  'svbrodersen/openscad.nvim',
  cmd = { 'OpenscadCheatsheet', 'OpenscadHelp', 'OpenscadExecFile' },
  ft = 'openscad',
  config = function()
    vim.g.openscad_load_snippets = true
    vim.g.openscad_fuzzy_finder = 'snacks'
    vim.g.openscad_pdf_command = 'zathura'
    require 'openscad'
  end,
  dependencies = { 'L3MON4D3/LuaSnip', 'folke/snacks.nvim' },
  keys = {
    { '<localleader>c', '<cmd>OpenscadCheatsheet<cr>', ft = 'openscad', desc = 'Openscad: cheatsheet' },
    { '<localleader>h', '<cmd>OpenscadHelp<cr>', ft = 'openscad', desc = 'Openscad: Help' },
    { '<localleader>o', '<cmd>OpenscadExecFile<cr>', ft = 'openscad', desc = 'Openscad: Open' },
    { '<localleader>o', '<cmd>OpenscadExecFile<cr>', ft = 'openscad', desc = 'Openscad: Open' },
  },
}
