local futhark_reload_group = vim.api.nvim_create_augroup('FutharkReloadGroup', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
  group = futhark_reload_group,
  pattern = '*.fut',
  callback = function()
    local filename = vim.fn.expand('%:p')
    -- Construct the command with a newline at the end
    local cmd = string.format(':load %s\n', filename)

    -- Iterate through all open buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      -- Check if the buffer is valid and is a terminal
      if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == 'terminal' then
        
        -- Get the buffer name (which includes the command for terminals, e.g., term://...//futhark repl)
        local name = vim.api.nvim_buf_get_name(buf)
        
        -- Check if the name matches the futhark repl pattern
        if name:find('futhark.*repl') then
          -- Get the channel ID required to send data to this terminal
          local chan = vim.bo[buf].channel
          
          if chan > 0 then
            -- Send the command silently to the terminal channel
            vim.api.nvim_chan_send(chan, cmd)
            
            -- Optional: Notify the user that the reload was sent
            -- vim.notify('Sent reload command to Futhark REPL', vim.log.levels.INFO)
            
            -- Stop after finding the first matching REPL (remove this break if you have multiple REPLs)
            break
          end
        end
      end
    end
  end,
})
