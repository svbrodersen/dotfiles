return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config|{}
  ---@diagnostics disable: missing-fields
  opts = {},
  keys = {
    {
      '<leader><space>',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>st',
      function()
        require('fzf-lua').todo()
      end,
      desc = 'Find Todo',
    }, -- todo-comments plugin required
    {
      '<leader>,',
      function()
        require('fzf-lua').buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>:',
      function()
        require('fzf-lua').command_history()
      end,
      desc = 'Command History',
    },

    -- FIND
    {
      '<leader>fb',
      function()
        require('fzf-lua').buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>fc',
      function()
        require('fzf-lua').files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Find Config File',
    },
    {
      '<leader>fg',
      function()
        require('fzf-lua').git_files()
      end,
      desc = 'Find Git Files',
    },
    {
      '<leader>fp',
      function()
        require('fzf-lua').projects()
      end,
      desc = 'Projects',
    },
    {
      '<leader>fr',
      function()
        require('fzf-lua').oldfiles()
      end,
      desc = 'Recent Files',
    },

    -- GIT
    {
      '<leader>gb',
      function()
        require('fzf-lua').git_branches()
      end,
      desc = 'Git Branches',
    },
    {
      '<leader>gl',
      function()
        require('fzf-lua').git_commits()
      end,
      desc = 'Git Log',
    },
    {
      '<leader>gL',
      function()
        require('fzf-lua').git_bcommits()
      end,
      desc = 'Git Log Line',
    },
    {
      '<leader>gs',
      function()
        require('fzf-lua').git_status()
      end,
      desc = 'Git Status',
    },
    {
      '<leader>gS',
      function()
        require('fzf-lua').git_stash()
      end,
      desc = 'Git Stash',
    },
    {
      '<leader>gd',
      function()
        require('fzf-lua').git_diff()
      end,
      desc = 'Git Diff',
    },
    {
      '<leader>gf',
      function()
        require('fzf-lua').git_bcommits()
      end,
      desc = 'Git Log File',
    },

    -- GREP
    {
      '<leader>/',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>sb',
      function()
        require('fzf-lua').lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sB',
      function()
        require('fzf-lua').grep_curbuf()
      end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>sw',
      function()
        require('fzf-lua').grep_cword()
      end,
      desc = 'Grep Word',
      mode = { 'n', 'x' },
    },

    -- SEARCH
    {
      '<leader>s"',
      function()
        require('fzf-lua').registers()
      end,
      desc = 'Registers',
    },
    {
      '<leader>s/',
      function()
        require('fzf-lua').search_history()
      end,
      desc = 'Search History',
    },
    {
      '<leader>sa',
      function()
        require('fzf-lua').autocmds()
      end,
      desc = 'Autocmds',
    },
    {
      '<leader>sc',
      function()
        require('fzf-lua').command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>sC',
      function()
        require('fzf-lua').commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>sd',
      function()
        require('fzf-lua').diagnostics_workspace()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sD',
      function()
        require('fzf-lua').diagnostics_document()
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>sh',
      function()
        require('fzf-lua').help_tags()
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>sH',
      function()
        require('fzf-lua').highlights()
      end,
      desc = 'Highlights',
    },
    {
      '<leader>sj',
      function()
        require('fzf-lua').jumps()
      end,
      desc = 'Jumps',
    },
    {
      '<leader>sk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>sl',
      function()
        require('fzf-lua').loclist()
      end,
      desc = 'Location List',
    },
    {
      '<leader>sm',
      function()
        require('fzf-lua').marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>sM',
      function()
        require('fzf-lua').man_pages()
      end,
      desc = 'Man Pages',
    },
    {
      '<leader>sq',
      function()
        require('fzf-lua').quickfix()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>uC',
      function()
        require('fzf-lua').colorschemes()
      end,
      desc = 'Colorschemes',
    },
  },
  ---@diagnostics enable: missing-fields
}
