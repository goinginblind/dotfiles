--- @module 'blink.cmp'
--- @type blink.cmp.Config
require('blink.cmp').setup {
  keymap = {
    -- 'default' (recommended) for mappings similar to built-in completions
    --   <c-y> to accept ([y]es) the completion.
    --    This will auto-import if your LSP supports it.
    --    This will expand snippets if the LSP sent a snippet.
    -- 'super-tab' for tab to accept
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- <tab>/<s-tab>: move to right/left of your snippet expansion
    -- <c-space>: Open menu or open docs if already open
    -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
    -- <c-e>: Hide menu
    -- <c-k>: Toggle signature help
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    preset = 'default',

    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  },

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono',
  },

  completion = {
    menu = {
      border = 'rounded',
      -- Use Normal directly (transparent) instead of going through BlinkCmpMenu,
      -- which defaults to linking Pmenu and can pick up its background color.
      -- This is mainly to ensure style consistency with any theme that is picked
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
    },
    documentation = {
      auto_show = false,
      auto_show_delay_ms = 500,
      window = {
        border = 'rounded',
        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
      },
    },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'lazydev' },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
    },
  },

  snippets = { preset = 'luasnip' },

  -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
  -- which automatically downloads a prebuilt binary when enabled.
  --
  -- By default, we use the Lua implementation instead, but you may enable
  -- the rust implementation via `'prefer_rust_with_warning'`
  --
  -- See :h blink-cmp-config-fuzzy for more information
  fuzzy = { implementation = 'prefer_rust_with_warning' },

  -- Shows a signature help window while you type arguments for a function
  signature = {
    enabled = true,
    window = {
      border = 'rounded',
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
    },
  },
}

-- Border highlights for blink.cmp windows (applied after setup).
-- Backgrounds are handled via winhighlight above using Normal directly.
vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { link = 'FloatBorder' })
vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { link = 'FloatBorder' })
vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelpBorder', { link = 'FloatBorder' })

-- List of all possible kind groups in blink.cmp
local kind_groups = {
  'BlinkCmpKind',
  'BlinkCmpKindText',
  'BlinkCmpKindMethod',
  'BlinkCmpKindFunction',
  'BlinkCmpKindConstructor',
  'BlinkCmpKindField',
  'BlinkCmpKindVariable',
  'BlinkCmpKindClass',
  'BlinkCmpKindInterface',
  'BlinkCmpKindModule',
  'BlinkCmpKindProperty',
  'BlinkCmpKindUnit',
  'BlinkCmpKindValue',
  'BlinkCmpKindEnum',
  'BlinkCmpKindKeyword',
  'BlinkCmpKindSnippet',
  'BlinkCmpKindColor',
  'BlinkCmpKindFile',
  'BlinkCmpKindReference',
  'BlinkCmpKindFolder',
  'BlinkCmpKindEnumMember',
  'BlinkCmpKindConstant',
  'BlinkCmpKindStruct',
  'BlinkCmpKindEvent',
  'BlinkCmpKindOperator',
  'BlinkCmpKindTypeParameter',
}

local additional_groups = {
  'BlinkCmpLabel',
  'BlinkCmpLabelDetail',
  'BlinkCmpLabelDescription',
}

local function apply_blink_kind_transparency()
  for _, group in ipairs(kind_groups) do
    vim.api.nvim_set_hl(0, group, { bg = 'NONE', ctermbg = 'NONE' })
  end

  for _, group in ipairs(additional_groups) do
    vim.api.nvim_set_hl(0, group, { bg = 'NONE', ctermbg = 'NONE' })
  end
end

-- Run immediately so :source works; also register for startup and colorscheme changes
apply_blink_kind_transparency()
-- Blink defers its own highlight init via vim.schedule, so we schedule after VimEnter
-- to ensure we run after blink's deferred setup has completed
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.schedule(apply_blink_kind_transparency)
  end,
})
-- Re-apply if the colorscheme changes later
vim.api.nvim_create_autocmd('ColorScheme', { callback = apply_blink_kind_transparency })
