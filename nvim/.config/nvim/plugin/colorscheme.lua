vim.pack.add({
    'https://github.com/sainnhe/gruvbox-material',
})

-- Optionally configure and load the colorscheme
-- directly inside the plugin declaration.
vim.g.gruvbox_material_enable_italic = true
vim.g.background = 'dark'
vim.g.gruvbox_material_visual = "green background"
vim.g.gruvbox_material_colors_override = {
  bg0 = {"#111111", "232"},
  bg1 = {"#161616", "234"},
  bg2 = {"#212121", "235"},
  bg3 = {"#262626", "237"},
  bg4 = {"#2b2b2b", "237"},
  bg5 = {"#353232", "239"}
}
vim.g.gruvbox_material_diagnostic_line_highlight = 1

vim.cmd.colorscheme('gruvbox-material')
