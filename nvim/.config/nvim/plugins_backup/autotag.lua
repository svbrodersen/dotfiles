return {
  {
    'windwp/nvim-ts-autotag',
    -- Use events that cover when you're likely to start editing a buffer
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,  -- Auto close tags (e.g., typing <div> gives </div>)
          enable_rename = true, -- Auto rename pairs (e.g., changing <div> to <span> also changes </div> to </span>)
        },
        -- This is the crucial part: Alias 'markdown' to use the 'html' rules
        aliases = {
          ['markdown'] = 'html',
        },
      })
    end,
    -- Make sure nvim-treesitter is a dependency, as nvim-ts-autotag relies on it
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
