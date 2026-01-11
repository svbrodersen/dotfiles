return {
  "esmuellert/codediff.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "CodeDiff",
  config = function()
    require("codediff").setup({
      highlights = {
        -- Line-level: accepts highlight group names or hex colors (e.g., "#2ea043")
        line_insert = "DiffAdd",      -- Line-level insertions
        line_delete = "DiffDelete",   -- Line-level deletions
      },

      -- Diff view behavior
      diff = {
        disable_inlay_hints = true,         -- Disable inlay hints in diff windows for cleaner view
        max_computation_time_ms = 5000,     -- Maximum time for diff computation 
        hide_merge_artifacts = true,       -- Hide merge tool temp files (*.orig, *.BACKUP.*, *.BASE.*, *.LOCAL.*, *.REMOTE.*)
        original_position = "left",         -- Position of original (old) content: "left" or "right"
      },

      -- Explorer panel configuration
      explorer = {
        position = "left",  -- "left" or "bottom"
        width = 40,         -- Width when position is "left" (columns)
        height = 15,        -- Height when position is "bottom" (lines)
        indent_markers = true,  -- Show indent markers in tree view (│, ├, └)
        view_mode = "list",    -- "list" or "tree"
        file_filter = {
          ignore = {},  -- Glob patterns to hide (e.g., {"*.lock", "dist/*"})
        },
      },

      -- Keymaps in diff view
      keymaps = {
        view = {
          quit = "q",                    -- Close diff tab
          toggle_explorer = "<leader>b",  -- Toggle explorer visibility (explorer mode only)
          next_hunk = "]c",   -- Jump to next change
          prev_hunk = "[c",   -- Jump to previous change
          next_file = "]f",   -- Next file in explorer mode
          prev_file = "[f",   -- Previous file in explorer mode
          diff_get = "do",    -- Get change from other buffer (like vimdiff)
          diff_put = "dp",    -- Put change to other buffer (like vimdiff)
        },
        explorer = {
          select = "<CR>",    -- Open diff for selected file
          hover = "K",        -- Show file diff preview
          refresh = "R",      -- Refresh git status
          toggle_view_mode = "i",  -- Toggle between 'list' and 'tree' views
          toggle_stage = "-", -- Stage/unstage selected file
          stage_all = "S",    -- Stage all files
          unstage_all = "U",  -- Unstage all files
          restore = "X",      -- Discard changes (restore file)
        },
        conflict = {
          accept_incoming = "<leader>ct",  -- Accept incoming (theirs/left) change
          accept_current = "<leader>co",   -- Accept current (ours/right) change
          accept_both = "<leader>cb",      -- Accept both changes (incoming first)
          discard = "<leader>cx",          -- Discard both, keep base
          next_conflict = "]x",            -- Jump to next conflict
          prev_conflict = "[x",            -- Jump to previous conflict
        },
      },
    })
  end,
}
