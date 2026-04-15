-- Register the FileType autocmd before treesitter setup so it is in place
-- when treesitter processes any file type events during or after startup.
-- NOTE: only start highlighting here — indentation is handled by
-- nvim-treesitter's indent module (configured below), not manually.
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- [[ Configure Treesitter ]] See :help nvim-treesitter
require('nvim-treesitter').setup {
  ensure_installed = {
    'bash',
    'c',
    'diff',
    'go',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'rust',
    'vim',
    'vimdoc',
  },

  -- Autoinstall languages that are not installed
  auto_install = true,
  highlight = {
    enable = true,
    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
    --  If you are experiencing weird indenting issues, add the language to
    --  the list of additional_vim_regex_highlighting and disabled languages for indent.
    additional_vim_regex_highlighting = { 'ruby' },
    disable = { 'csv' },
  },
  indent = {
    enable = true,
    disable = {
      'ruby',
      -- Treesitter's Lua indent returns wrong values in some contexts (e.g. 'o'
      -- on a new line), so fall back to Neovim's built-in Lua indentation.
      'lua',
    },
  },
}
