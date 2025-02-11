return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
  },
  opts = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")

    mason.setup()
    lspconfig.html.setup({
      filetypes = { "html", "templ" },
    })

    lspconfig.htmx.setup({
      filetypes = { "html", "templ" },
    })

    lspconfig.tailwindcss.setup({
      filetypes = { "templ", "astro", "javascript", "typescript", "react" },
      settings = {
        tailwindCSS = {
          includeLanguages = {
            templ = "html",
          },
        },
      },
    })
  end,
}
