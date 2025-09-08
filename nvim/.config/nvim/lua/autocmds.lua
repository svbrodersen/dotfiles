vim.api.nvim_create_user_command('ToggleSpell', function()
  vim.o.spell = not vim.o.spell
end, { desc = 'Toggles spelling' })
