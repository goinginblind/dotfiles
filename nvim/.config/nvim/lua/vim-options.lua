-- Set the default shell to be bash
vim.o.shell = '/usr/bin/bash'

-- Set conceallevel to 1, .md files require this to be set to 2
-- to provide the nicer 'view' look similiar to Obsidian
vim.o.conceallevel = 1

-- [[ Setting options ]]
-- See :help vim.o
-- For more options, you can see :help option-list

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Rounded borders for all windows
vim.o.winborder = 'rounded'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after UiEnter because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See :help 'clipboard'
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable line wrapping
vim.opt.wrap = true

-- Enable linebreak,
-- so the words are wrapped fully
vim.opt.linebreak = true

-- Add visual indication for line breaks
vim.opt.showbreak = '↳ '

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See :help 'list'
--  and :help 'listchars'

--  Notice listchars is set using vim.opt instead of vim.o.
--  It is very similar to vim.o but offers an interface for conveniently interacting with tables.
--   See :help lua-options
--   and :help lua-options-guide
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like :q),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See :help 'confirm'
vim.o.confirm = true
