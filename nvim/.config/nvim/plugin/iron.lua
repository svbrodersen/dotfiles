vim.pack.add {
  'https://github.com/Vigemus/iron.nvim.git',
}

local iron = require 'iron.core'
local view = require 'iron.view'
local common = require 'iron.fts.common'

local conda_python = os.getenv 'CONDA_PREFIX' .. '/bin/python'

require('iron').setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = { 'fish' },
      },
      python = {
        -- Use a function to dynamically resolve the path when the REPL starts
        command = function(meta)
          local conda_prefix = os.getenv 'CONDA_PREFIX'
          if conda_prefix then
            return { conda_prefix .. '/bin/python' }
          else
            return { 'python' } -- Fallback if no Conda environment is active
          end
        end,
        format = common.bracketed_paste_python,
        block_dividers = { '# %%', '#%%' },
        env = { PYTHON_BASIC_REPL = '1' }, -- Needed for python 3.13+
      },
      fut = {
        command = function(meta)
          local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
          return { 'futhark', 'repl', filename }
        end,
      },
    },
    -- set the file type of the newly created repl to ft
    -- bufnr is the buffer id of the REPL and ft is the filetype of the
    -- language being used for the REPL.
    repl_filetype = function(bufnr, ft)
      return ft
      -- or return a string name such as the following
      -- return "iron"
    end,
    -- Send selections to the DAP repl if an nvim-dap session is running.
    dap_integration = true,
    -- How the repl window will be displayed
    -- See below for more information
    repl_open_cmd = view.split.vertical.botright(0.4),

    -- repl_open_cmd can also be an array-style table so that multiple
    -- repl_open_commands can be given.
    -- When repl_open_cmd is given as a table, the first command given will
    -- be the command that `IronRepl` initially toggles.
    -- Moreover, when repl_open_cmd is a table, each key will automatically
    -- be available as a keymap (see `keymaps` below) with the names
    -- toggle_repl_with_cmd_1, ..., toggle_repl_with_cmd_k
    -- For example,
    --
    -- repl_open_cmd = {
    --   view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right
    --   view.split.rightbelow("%25")  -- cmd_2: open a repl below
    -- }
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = '<space>rc',
    visual_send = '<space>rc',
    send_file = '<space>rf',
    send_line = '<space>rl',
    send_mark = '<space>rm',
    mark_motion = '<space>rmc',
    mark_visual = '<space>rmc',
    remove_mark = '<space>rmd',
    cr = '<space>r<cr>',
    interrupt = '<space>r<space>',
    exit = '<space>rq',
    clear = '<space>rx',
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true,
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}
