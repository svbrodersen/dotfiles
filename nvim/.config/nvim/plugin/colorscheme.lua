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
  bg1 = {"#141414", "234"},
  bg2 = {"#191919", "235"},
  bg3 = {"#212121", "237"},
  bg4 = {"#211f1f", "237"},
  bg5 = {"#262424", "239"}
}
vim.g.gruvbox_material_diagnostic_line_highlight = 1

vim.cmd.colorscheme('gruvbox-material')
