vim.pack.add {
  'https://github.com/mfussenegger/nvim-lint',
}

local lint = require 'lint'

-- Set the linters by filetype
lint.linters_by_ft = {
  markdown = { 'markdownlint' },
}

-- Define the specific linter configuration with your
-- dynamic 'args' function
lint.linters.markdownlint.args = {
  function()
    -- Helper function to find project root and check for 'slides.md'
    local function is_slidev_project()
      local root = vim.fs.find({ 'slides.md', '.git' }, {
        path = vim.api.nvim_buf_get_name(0),
        upward = true,
      })

      if root and #root > 0 then
        local root_path = vim.fn.fnamemodify(root[1], ':h')
        if vim.fn.filereadable(root_path .. '/slides.md') == 1 then
          return true
        end
      end
      return false
    end

    -- If it's a slidev project, return relaxed rules
    if is_slidev_project() then
      return '--disable MD013 MD041'
    end
    -- Otherwise, return default arguments
    return ''
  end,
}

-- Create autocommand which carries out the actual linting
-- on the specified events.
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    -- Only run the linter in buffers that you can modify in order to
    -- avoid superfluous noise, notably within the handy LSP pop-ups that
    -- describe the hovered symbol using Markdown.
    if vim.bo.modifiable then
      lint.try_lint()
    end
  end,
})
