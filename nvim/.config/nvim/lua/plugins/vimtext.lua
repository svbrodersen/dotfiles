return {
  "lervag/vimtex",
  lazy = false, -- lazy-loading will disable inverse search
  config = function()
    vim.g.vimtex_syntax_conceal_disable = true
    vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
    vim.g.vimtex_compiler_progname = "lualatex"
  end,
  keys = {
    { "<localLeader>l", "", desc = "+vimtext" },
  },
}
