return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = { -- ← required wrapper
              hints = {
                parameterNames = false, -- disable param name hints
                rangeVariableTypes = false, -- disable range var type hints
              },
            },
          },
        },
        html = {},
        htmx = {},
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "html",
        "htmx",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        asm = { "asmfmt" },
      },
    },
  },
}
