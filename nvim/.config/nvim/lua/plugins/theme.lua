require('catppuccin').setup {
  flavour = 'mocha',
  float = {
    transparent = true,
    solid = false,
  },
  auto_integrations = true,
}

vim.cmd.colorscheme 'catppuccin'

-- Re-apply transparency overrides after colorscheme loads.
-- Catppuccin's transparent mode handles Normal/NormalFloat, but these
-- ensure the gutter and edge-of-buffer areas also stay transparent.
local function apply_transparency()
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
