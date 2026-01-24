# kickstart.nvim

## Introduction

* Minimal Kickstart Neovim setup (see [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim))
* My own tweaks include:
    - Fix to the LSP config parsing (it parsed the LSP themselves, but not their configuration in the original)
    - LSPs configured for (besides default Lua one): 
        - Rust (both rust-analyzer and clippy)
        - Go (gopls, goimports on save, staticcheck)
        - C
        - Python (ruff and pyright)
    - Obsidian integration for quick notetaking, but if someone ever reads this - **be sure to set keymaps**!
    - Minor visual stuff like catpuccin theme, some style changes for markdown, giticons, etc.
    - And that's it!

