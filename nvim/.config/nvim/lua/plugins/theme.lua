return { -- Setup colorscheme to Catppuccin Mocha
  'catppuccin/nvim',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      float = {
        transparent = true,
        solid = false,
      },
      auto_integrations = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        mini = {
          enabled = true,
        },
        telescope = {
          enabled = true,
        },
        blink_cmp = {
          style = 'bordered',
        },
        dap = true,
        which_key = true,
        fidget = true,
        mason = true,
      },

      custom_highlights = function(colors)
        return {
          BlinkCmpMenu = { bg = colors.base }, -- Main Completion Menu
          BlinkCmpMenuBorder = { fg = colors.blue, bg = colors.base },

          BlinkCmpDoc = { bg = colors.base }, -- Documentation Popup
          BlinkCmpDocBorder = { fg = colors.blue, bg = colors.base },

          BlinkCmpSignatureHelp = { bg = colors.base }, -- Signature Help
          BlinkCmpSignatureHelpBorder = { fg = colors.blue, bg = colors.base },

          -- Markdown styling
          -- ['@markup.italic'] = { fg = colors.green, italic = true }, -- italics
          -- ['@markup.italic.markdown_inline'] = { fg = colors.green, italic = true },
          --
          -- ['@markup.strong'] = { fg = colors.sky, bold = true }, -- bold
          -- ['@markup.strong.markdown_inline'] = { fg = colors.sky, bold = true },
          --
          -- ['@markup.italic.strong.markdown_inline'] = { fg = colors.yellow, bold = true, italic = true }, -- bold italics
          --
          -- ['@markup.quote.markdown'] = { fg = colors.text }, -- quotes
          --
          -- ['@markup.raw.block.markdown'] = { fg = colors.mauve }, -- .md code blocks
          -- ['@markup.raw.markdown_inline'] = { fg = colors.mauve }, -- inline .md code blocks
        }
      end,
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
