return {
  'lervag/vimtex',
  lazy = false, -- lazy-loading will disable inverse search
  init = function()
    vim.g.vimtex_syntax_conceal_disable = true
  end,
}
