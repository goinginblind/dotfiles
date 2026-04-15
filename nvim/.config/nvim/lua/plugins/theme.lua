-- No colorscheme plugin — stock Neovim theme is used.
-- This file only applies transparency overrides so the terminal background shows through.

local function apply_transparency()
  -- Main editor windows
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'NONE' })

  -- Gutter
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'LineNr', { bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'LineNrAbove', { bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'LineNrBelow', { bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = 'NONE' })
end

apply_transparency()

-- Re-apply if the user or a plugin changes the colorscheme later
vim.api.nvim_create_autocmd('ColorScheme', { callback = apply_transparency })
