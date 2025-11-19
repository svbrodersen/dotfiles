local futhark_reload_group = vim.api.nvim_create_augroup('FutharkReloadGroup', { clear = true })

local function isReplRunning()
  local handle = io.popen("pgrep -f 'futhark.*repl'")
  local result = handle:read("*a")
  handle:close()
  if not result or result == '' then return false end
  return true
end

vim.api.nvim_create_autocmd('BufWritePost', {
  group = futhark_reload_group,
  pattern = '*.fut',
  callback = function()
    if not isReplRunning() then return end
    -- If there is a repl running, then we assume it is our next pane
    local filename = vim.fn.expand '%:p'
    local repl_cmd = string.format(':load %s\n', filename)
    vim.fn.system { 'zellij', 'action', 'focus-next-pane' }
    vim.fn.system { 'zellij', 'action', 'write-chars', repl_cmd }
    vim.fn.system { 'zellij', 'action', 'focus-previous-pane' }
  end,
})
