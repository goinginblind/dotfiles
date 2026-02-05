return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  event = {
    'BufReadPre ' .. vim.fn.expand '~' .. '/Documents/Obsidian/main/*.md',
    'BufNewFile ' .. vim.fn.expand '~' .. '/Documents/Obsidian/main/*.md',
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'main',
        path = '~/Documents/Obsidian/main',
      },
    },
    -- This allows for all the ghost notes to lead into specified folder
    -- when they are created from the inline traversal into new note
    notes_subdir = 'notes',
    new_notes_location = 'notes_subdir',

    -- Almost the same as the above - just that the media files are saved in the 'files'
    -- folder, still prompts for the name of the pasted images - useful when you paste
    -- a screenshot - their names are usually 2025-10-11-17-36-12.png or something like that.
    attachments = {
      folder = 'files',
    },

    -- Here we have a small function that makes the id of the note
    -- match the name of the note the moment it's created: thus,
    -- new .md files themselves are same as their contents, instead
    -- of the randomly generated ids - hence, no more create-rename loop
    note_id_func = function(title)
      -- just use the title as filename (fallback to "untitled")
      return title or 'untitled'
    end,
  },
}
