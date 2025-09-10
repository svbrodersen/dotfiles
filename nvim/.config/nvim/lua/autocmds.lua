vim.api.nvim_create_user_command('ToggleSpell', function()
  vim.o.spell = not vim.o.spell
end, { desc = 'Toggles spelling' })

local spell_types = { 'tex', 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' }

-- Create an augroup for spellcheck to group related autocommands
vim.api.nvim_create_augroup('Spellcheck', { clear = true })

-- Create an autocommand to enable spellcheck for specified file types
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = 'Spellcheck', -- Grouping the command for easier management
  pattern = spell_types, -- Only apply to these file types
  callback = function()
    vim.opt_local.spell = true -- Enable spellcheck for these file types
  end,
  desc = 'Enable spellcheck for defined filetypes', -- Description for clarity
})
