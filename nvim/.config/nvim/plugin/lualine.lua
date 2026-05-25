vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
}

local function find_key(func)
  for _, map in ipairs(vim.api.nvim_get_keymap('n')) do
    if map.callback == func then
      return map.lhs, map.desc
    end
  end
end

local function key_sort_val(lhs)
  local fnum = lhs:match('<F(%d+)>')
  if fnum then
    return 0, tonumber(fnum)
  end
  return 1, lhs
end

local function dap_status()
  local ok, dap = pcall(require, 'dap')
  if not ok or dap.session() == nil then
    return ''
  end
  local actions = {
    { dap.continue,      'Continue' },
    { dap.step_over,     'Over' },
    { dap.step_into,     'Into' },
    { dap.step_back,     'Back' },
    { dap.step_out,      'Out' },
    { dap.run_to_cursor, 'RunCursor' },
    { dap.restart,       'Restart' },
    { dap.terminate,     'Terminate' },
  }
  local items = {}
  for _, action in ipairs(actions) do
    local key = find_key(action[1])
    if key then
      table.insert(items, { key = key, label = action[2] })
    end
  end
  table.sort(items, function(a, b)
    local a1, a2 = key_sort_val(a.key)
    local b1, b2 = key_sort_val(b.key)
    if a1 ~= b1 then
      return a1 < b1
    end
    if type(a2) == 'number' and type(b2) == 'number' then
      return a2 < b2
    end
    return tostring(a2) < tostring(b2)
  end)
  local parts = {}
  for _, item in ipairs(items) do
    table.insert(parts, item.key .. ': ' .. item.label)
  end
  return table.concat(parts, '  ')
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

