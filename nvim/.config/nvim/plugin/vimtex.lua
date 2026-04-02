vim.pack.add({
  'https://github.com/lervag/vimtex',
})

vim.g.vimtex_syntax_conceal_disable = true
vim.g.vimtex_mappings_disable = { ['n'] = { 'K' } }
vim.g.vimtex_compiler_progname = 'lualatex'
vim.g.vimtex_view_method = 'zathura'
