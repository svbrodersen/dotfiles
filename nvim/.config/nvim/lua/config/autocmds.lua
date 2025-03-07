-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Don't create a new comment after using o in normal mode
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove("o")
  end,
})

local function find_next_conflict(bufnr)
  -- Get the current cursor position; returns {line, col}
  local cursor = vim.api.nvim_win_get_cursor(0)
  local current_line = cursor[1]
  local total_lines = vim.api.nvim_buf_line_count(bufnr)

  -- Loop from the current line to the end of the buffer
  for i = current_line, total_lines do
    local line = vim.api.nvim_buf_get_lines(bufnr, i - 1, i, false)[1]
    if line and line:find("<<<<<<<") then
      vim.api.nvim_win_set_cursor(0, { i, 0 })
    end
  end

  vim.notify("No merge conflict found")
end

local function find_conflict(bufnr, forward)
  -- Get the current cursor position; returns {line, col}
  local cursor = vim.api.nvim_win_get_cursor(0)
  local current_line = cursor[1]
  local total_lines
  local step
  if forward then
    total_lines = vim.api.nvim_buf_line_count(bufnr)
    step = 1
  else
    total_lines = 1
    step = -1
  end
  -- Loop from the current line to the end of the buffer
  for line_num = current_line, total_lines, step do
    -- inclusive start exclusive end
    local line = vim.api.nvim_buf_get_lines(bufnr, line_num - 1, line_num, false)[1]
    if line:find("<<<<<<<") then
      return line_num
    end
  end
end

vim.api.nvim_create_autocmd("DiffUpdated", {
  pattern = "*",
  callback = function()
    if vim.opt.diff:get() then
      vim.keymap.set("n", "<C-c>l", ":diffget LO<CR>", {
        buffer = true,
        desc = "Diffget LO",
      })

      vim.keymap.set("n", "<C-c>r", ":diffget RE<CR>", {
        buffer = true,
        desc = "Diffget RE",
      })

      vim.keymap.set("n", "<C-c>b", function()
        vim.cmd("diffget LO | diffget RE")
      end, {
        buffer = true,
        desc = "Diffget BOTH",
      })

      vim.keymap.set("n", "<C-c>n", function()
        local line_num = find_conflict(0, true)
        if line_num then
          vim.api.nvim_win_set_cursor(0, { line_num, 0 })
        else
          vim.notify("No merge conflict found")
        end
      end)

      vim.keymap.set("n", "<C-c>p", function()
        local line_num = find_conflict(0, false)
        if line_num then
          vim.api.nvim_win_set_cursor(0, { line_num, 0 })
        else
          vim.notify("No merge conflict found")
        end
      end)
    end
  end,
})
