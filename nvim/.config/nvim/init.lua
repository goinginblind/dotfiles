-- Set <space> as the leader key
-- :help mapleader
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set nerd font setting
vim.g.have_nerd_font = false

-- Load core configuration
require 'vim-options'
require 'keymaps'
require 'autocommands'

-- [[ Install plugins via vim.pack ]]
local plugins = {
  -- Core dependencies
  { src = 'https://github.com/nvim-lua/plenary.nvim' },

  -- LSP stack
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/j-hui/fidget.nvim' },
  { src = 'https://github.com/folke/lazydev.nvim' },

  -- Completion
  { src = 'https://github.com/L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
  { src = 'https://github.com/saghen/blink.cmp' },

  -- Treesitter
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  -- Telescope
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },

  -- Formatting
  { src = 'https://github.com/stevearc/conform.nvim' },

  -- Git
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },

  -- UI & editing utilities
  { src = 'https://github.com/echasnovski/mini.nvim' },
  { src = 'https://github.com/NMAC427/guess-indent.nvim' },
  { src = 'https://github.com/windwp/nvim-autopairs' },
  { src = 'https://github.com/folke/which-key.nvim' },
}

-- Only install telescope-fzf-native when make is available
if vim.fn.executable 'make' == 1 then
  table.insert(plugins, { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', build = 'make' })
end

-- Only install devicons when a Nerd Font is available
if vim.g.have_nerd_font then
  table.insert(plugins, { src = 'https://github.com/nvim-tree/nvim-web-devicons' })
end

vim.pack.add(plugins)

-- [[ Configure plugins ]]
-- Order matters: blink first (so capabilities are ready for LSP), then LSP, then everything else.
require 'plugins.theme'
require 'plugins.blink'
require 'plugins.lsp'
require 'plugins.treesitter'
require 'plugins.conform'
require 'plugins.gitsigns'
require 'plugins.telescope'
require 'plugins.mini'
require 'plugins.misc'

-- :help modeline
-- vim: ts=2 sts=2 sw=2 et
