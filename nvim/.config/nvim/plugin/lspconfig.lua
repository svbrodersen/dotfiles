vim.pack.add {
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason-lspconfig.nvim.git',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/saghen/blink.cmp',
}

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      -- Simplifies your previous format function
      return diagnostic.message
    end,
  },
}

require('fidget').setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Keymaps
    local Snacks = require 'snacks'
    map('<leader>cr', vim.lsp.buf.rename, 'Rename')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
    map('<leader>cd', function()
      vim.diagnostic.open_float(nil, { scope = 'line', focus = false })
    end, 'Code Diagnostics', { 'n', 'x' })
    map('gd', Snacks.picker.lsp_definitions, 'Goto Definition')
    map('gD', Snacks.picker.lsp_declarations, 'Goto Declaration')
    map('gr', Snacks.picker.lsp_references, 'References')
    map('gI', Snacks.picker.lsp_implementations, 'Goto Implementation')
    map('gy', Snacks.picker.lsp_type_definitions, 'Goto Type Definition')
    map('<leader>ss', Snacks.picker.lsp_symbols, 'LSP Symbols')
    map('<leader>sS', Snacks.picker.lsp_workspace_symbols, 'LSP Workspace Symbols')

    -- Document Highlights
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

-- Servers
local capabilities = require('blink.cmp').get_lsp_capabilities()

local servers = {
  clangd = {
    on_attach = function(client, bufnr)
      if vim.bo[bufnr].filetype == 'cuda' then
        client.notify('textDocument/didOpen', {
          textDocument = {
            uri = vim.uri_from_bufnr(bufnr),
            languageId = 'cuda',
            version = 0,
            text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), '\n'),
          },
        })
      end
    end,
  },

  -- Put rust_analyzer back here
  rust_analyzer = {
    -- Note: standard lspconfig expects settings under the 'settings' key,
    -- unlike rustaceanvim which wrapped it in 'default_settings'
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          buildScripts = { enable = true },
        },
        check = {
          command = 'clippy',
          extraArgs = { '--', '-W', 'clippy::all', '-W', 'clippy::pedantic' },
        },
        checkOnSave = true,
        diagnostics = { enable = true },
        procMacro = { enable = true },
        files = {
          exclude = {
            '.direnv',
            '.git',
            '.jj',
            '.github',
            '.gitlab',
            'bin',
            'node_modules',
            'target',
            'venv',
            '.venv',
          },
          watcher = 'client',
        },
      },
    },
  },
  gopls = { gofumpt = true },
  pyright = {},
  neocmake = {},
  jdtls = {},
  texlab = {},
  html = {
    filetypes = {
      'html',
      'rust',
    },
    init_options = {
      userLanguages = {
        eelixir = 'html-eex',
        eruby = 'erb',
        rust = 'html',
      },
    },
  },
  emmet_language_server = {
    filetypes = {
      'html',
      'rust',
    },
    init_options = {
      userLanguages = {
        eelixir = 'html-eex',
        eruby = 'erb',
        rust = 'html',
      },
    },
  },
  tailwindcss = {
    filetypes = {
      'html',
      'rust',
    },
    init_options = {
      userLanguages = {
        eelixir = 'html-eex',
        eruby = 'erb',
        rust = 'html',
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = 'Replace' },
      },
    },
  },
}

local all_tools = vim.tbl_keys(servers)
vim.list_extend(all_tools, { 'stylua', 'markdownlint' })

require('mason-tool-installer').setup { ensure_installed = all_tools }

for server_name, server_config in pairs(servers) do
  server_config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_config.capabilities or {})

  vim.lsp.config(server_name, server_config)
  vim.lsp.enable(server_name)
end

-- Neovim 0.11 native LSP initialization for specific servers
if vim.fn.executable 'futhark-lsp' == 1 then
  vim.lsp.enable 'futhark_lsp'
end
