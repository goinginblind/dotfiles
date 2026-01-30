# config.nu
#
# Installed by:
# version = "0.108.0"

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# >>>>>>>>>>>>>>>>>>>>> THEME DEFINITION >>>>>>>>>>>>>>>>>>>>>>>

# Define the Palette
let theme = {
    rosewater: "#f5e0dc"
    flamingo: "#f2cdcd"
    pink: "#f5c2e7"
    mauve: "#cba6f7"
    red: "#f38ba8"
    maroon: "#eba0ac"
    peach: "#fab387"
    yellow: "#f9e2af"
    green: "#a6e3a1"
    teal: "#94e2d5"
    sky: "#89dceb"
    sapphire: "#74c7ec"
    blue: "#89b4fa"
    lavender: "#b4befe"
    text: "#cdd6f4"
    subtext1: "#bac2de"
    subtext0: "#a6adc8"
    overlay2: "#9399b2"
    overlay1: "#7f849c"
    overlay0: "#6c7086"
    surface2: "#585b70"
    surface1: "#45475a"
    surface0: "#313244"
    base: "#1e1e2e"
    mantle: "#181825"
    crust: "#11111b"
}

# Define the Scheme
let scheme = {
    recognized_command: $theme.blue
    unrecognized_command: $theme.text
    constant: $theme.peach
    punctuation: $theme.overlay2
    operator: $theme.sky
    string: $theme.green
    virtual_text: $theme.surface2
    variable: { fg: $theme.flamingo attr: i }
    filepath: $theme.yellow
}

# Build the actual NuShell color configuration record
let catppuccin_color_config = {
    separator: { fg: $theme.surface2 attr: b }
    leading_trailing_space_bg: { fg: $theme.lavender attr: u }
    header: { fg: $theme.text attr: b }
    row_index: $scheme.virtual_text
    record: $theme.text
    list: $theme.text
    hints: $scheme.virtual_text
    search_result: { fg: $theme.base bg: $theme.yellow }
    shape_closure: $theme.teal
    closure: $theme.teal
    shape_flag: { fg: $theme.maroon attr: i }
    shape_matching_brackets: { attr: u }
    shape_garbage: $theme.red
    shape_keyword: $theme.mauve
    shape_match_pattern: $theme.green
    shape_signature: $theme.teal
    shape_table: $scheme.punctuation
    cell-path: $scheme.punctuation
    shape_list: $scheme.punctuation
    shape_record: $scheme.punctuation
    shape_vardecl: $scheme.variable
    shape_variable: $scheme.variable
    empty: { attr: n }
    # Dynamic coloring based on size/duration/time
    filesize: {||
        if $in < 1kb { $theme.teal } else if $in < 10kb { $theme.green } else if $in < 100kb { $theme.yellow } else if $in < 10mb { $theme.peach } else if $in < 100mb { $theme.maroon } else if $in < 1gb { $theme.red } else { $theme.mauve }
    }
    duration: {||
        if $in < 1day { $theme.teal } else if $in < 1wk { $theme.green } else if $in < 4wk { $theme.yellow } else if $in < 12wk { $theme.peach } else if $in < 24wk { $theme.maroon } else if $in < 52wk { $theme.red } else { $theme.mauve }
    }
    datetime: {|| (date now) - $in |
        if $in < 1day { $theme.teal } else if $in < 1wk { $theme.green } else if $in < 4wk { $theme.yellow } else if $in < 12wk { $theme.peach } else if $in < 24wk { $theme.maroon } else if $in < 52wk { $theme.red } else { $theme.mauve }
    }
    shape_external: $scheme.unrecognized_command
    shape_internalcall: $scheme.recognized_command
    shape_external_resolved: $scheme.recognized_command
    shape_block: $scheme.recognized_command
    block: $scheme.recognized_command
    shape_custom: $theme.pink
    custom: $theme.pink
    background: $theme.base
    foreground: $theme.text
    cursor: { bg: $theme.rosewater fg: $theme.base }
    shape_range: $scheme.operator
    range: $scheme.operator
    shape_pipe: $scheme.operator
    shape_operator: $scheme.operator
    shape_redirection: $scheme.operator
    glob: $scheme.filepath
    shape_directory: $scheme.filepath
    shape_filepath: $scheme.filepath
    shape_glob_interpolation: $scheme.filepath
    shape_globpattern: $scheme.filepath
    shape_int: $scheme.constant
    int: $scheme.constant
    bool: $scheme.constant
    float: $scheme.constant
    nothing: $scheme.constant
    binary: $scheme.constant
    shape_nothing: $scheme.constant
    shape_bool: $scheme.constant
    shape_float: $scheme.constant
    shape_binary: $scheme.constant
    shape_datetime: $scheme.constant
    shape_literal: $scheme.constant
    string: $scheme.string
    shape_string: $scheme.string
    shape_string_interpolation: $theme.flamingo
    shape_raw_string: $scheme.string
    shape_externalarg: $scheme.string
}

# Build the Explore configuration using theme variables
let catppuccin_explore_config = {
    status_bar_background: { fg: $theme.text, bg: $theme.mantle },
    command_bar_text: { fg: $theme.text },
    highlight: { fg: $theme.base, bg: $theme.yellow },
    status: {
        error: $theme.red,
        warn: $theme.yellow,
        info: $theme.blue,
    },
    selected_cell: { bg: $theme.blue fg: $theme.base },
}

# >>>>>>>>>>>>>>>>>>>>>>> MAIN CONFIGURATION >>>>>>>>>>>>>>>>>>>>>>>>
$env.config = {
    show_banner: false

    ls: {
        use_ls_colors: true 
        clickable_links: true
    }

    rm: {
        always_trash: false 
    }

    table: {
        mode: rounded 
        index_mode: always 
        show_empty: true 
        padding: { left: 1, right: 1 } 
        trim: {
            methodology: wrapping 
            wrapping_try_keep_words: true 
            truncating_suffix: "..." 
        }
        header_on_separator: false 
    }

    error_style: "fancy" 

    datetime_format: {}

    explore: $catppuccin_explore_config

    history: {
        max_size: 100_000 
        sync_on_enter: true 
        file_format: "plaintext" 
        isolation: false 
    }

    completions: {
        case_sensitive: false 
        quick: true    
        partial: true    
        algorithm: "prefix"    
        external: {
            enable: true 
            max_results: 100 
            completer: null 
        }
        use_ls_colors: true 
    }

    cursor_shape: {
        emacs: block 
        vi_insert: block 
        vi_normal: underscore 
    }

    color_config: $catppuccin_color_config
    
    float_precision: 2 
    buffer_editor: "" 
    use_ansi_coloring: true
    bracketed_paste: true 
    edit_mode: vi 
    
    shell_integration: {
        osc2: true
        osc7: true
        osc8: true
        osc9_9: false
        osc133: true
        osc633: true
        reset_application_mode: true
    }
    
    render_right_prompt_on_last_line: false 
    use_kitty_protocol: false 
    highlight_resolved_externals: true 
    recursion_limit: 50 

    plugins: {} 

    plugin_gc: {
        default: {
            enabled: true 
            stop_after: 10sec 
        }
        plugins: {}
    }

    hooks: {
        pre_prompt: [{|| 
            if (which direnv | is-empty) {
                return
            }
            try {
                direnv export json | from json | default {} | load-env
                if 'PATH' in $env {
                    $env.PATH = ($env.PATH | split row (char esep))
                }
            } catch {}
        }]
        pre_execution: [{ null }] 
        env_change: {
            PWD: [{|before, after| null }] 
        }
        display_output: "if (term size).columns >= 100 { table -e } else { table }" 
        command_not_found: { null } 
    }

    menus: [
        {
            name: completion_menu
            only_buffer_difference: false
            marker: "| "
            type: {
                layout: columnar
                columns: 4
                col_width: 20
                col_padding: 2
            }
            style: {
                text: $theme.green
                selected_text: { fg: $theme.base bg: $theme.green attr: b }
                description_text: $theme.yellow
                match_text: { attr: u }
                selected_match_text: { attr: ur }
            }
        }
        {
            name: ide_completion_menu
            only_buffer_difference: false
            marker: "| "
            type: {
                layout: ide
                min_completion_width: 0,
                max_completion_width: 50,
                max_completion_height: 10,
                padding: 0,
                border: true,
                cursor_offset: 0,
                description_mode: "prefer_right"
                min_description_width: 0
                max_description_width: 50
                max_description_height: 10
                description_offset: 1
                correct_cursor_pos: false
            }
            style: {
                text: $theme.green
                selected_text: { fg: $theme.base bg: $theme.green attr: b }
                description_text: $theme.yellow
                match_text: { attr: u }
                selected_match_text: { attr: ur }
            }
        }
        {
            name: history_menu
            only_buffer_difference: true
            marker: "? "
            type: {
                layout: list
                page_size: 10
            }
            style: {
                text: $theme.green
                selected_text: { fg: $theme.base bg: $theme.green attr: b }
                description_text: $theme.yellow
            }
        }
        {
            name: help_menu
            only_buffer_difference: true
            marker: "? "
            type: {
                layout: description
                columns: 4
                col_width: 20
                col_padding: 2
                selection_rows: 4
                description_rows: 10
            }
            style: {
                text: $theme.green
                selected_text: { fg: $theme.base bg: $theme.green attr: b }
                description_text: $theme.yellow
            }
        }
    ]

    keybindings: [
        {
            name: delete_one_word_backward
            modifier: alt
            keycode: backspace
            mode: [emacs, vi_normal, vi_insert]
            event: {edit: backspaceword}
        }
        {
            name: completion_menu
            modifier: none
            keycode: tab
            mode: [emacs vi_normal vi_insert]
            event: {
                until: [
                    { send: menu name: completion_menu }
                    { send: menunext }
                    { edit: complete }
                ]
            }
        }
        {
            name: ide_completion_menu
            modifier: control
            keycode: char_n
            mode: [emacs vi_normal vi_insert]
            event: {
                until: [
                    { send: menu name: ide_completion_menu }
                    { send: menunext }
                    { edit: complete }
                ]
            }
        }
        {
            name: history_menu
            modifier: control
            keycode: char_r
            mode: [emacs, vi_insert, vi_normal]
            event: { send: menu name: history_menu }
        }
        {
            name: help_menu
            modifier: none
            keycode: f1
            mode: [emacs, vi_insert, vi_normal]
            event: { send: menu name: help_menu }
        }
        {
            name: completion_previous_menu
            modifier: shift
            keycode: backtab
            mode: [emacs, vi_normal, vi_insert]
            event: { send: menuprevious }
        }
        {
            name: next_page_menu
            modifier: control
            keycode: char_x
            mode: emacs
            event: { send: menupagenext }
        }
        {
            name: undo_or_previous_page_menu
            modifier: control
            keycode: char_z
            mode: emacs
            event: {
                until: [
                    { send: menupageprevious }
                    { edit: undo }
                ]
            }
        }
        {
            name: escape
            modifier: none
            keycode: escape
            mode: [emacs, vi_normal, vi_insert]
            event: { send: esc }
        }
        {
            name: cancel_command
            modifier: control
            keycode: char_c
            mode: [emacs, vi_normal, vi_insert]
            event: { send: ctrlc }
        }
        {
            name: quit_shell
            modifier: control
            keycode: char_d
            mode: [emacs, vi_normal, vi_insert]
            event: { send: ctrld }
        }
        {
            name: clear_screen
            modifier: control
            keycode: char_l
            mode: [emacs, vi_normal, vi_insert]
            event: { send: clearscreen }
        }
        {
            name: search_history
            modifier: control
            keycode: char_q
            mode: [emacs, vi_normal, vi_insert]
            event: { send: searchhistory }
        }
        {
            name: open_command_editor
            modifier: control
            keycode: char_o
            mode: [emacs, vi_normal, vi_insert]
            event: { send: openeditor }
        }
        {
            name: move_up
            modifier: none
            keycode: up
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: menuup }
                    { send: up }
                ]
            }
        }
        {
            name: move_down
            modifier: none
            keycode: down
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: menudown }
                    { send: down }
                ]
            }
        }
        {
            name: move_left
            modifier: none
            keycode: left
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: menuleft }
                    { send: left }
                ]
            }
        }
        {
            name: move_right_or_take_history_hint
            modifier: none
            keycode: right
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: historyhintcomplete }
                    { send: menuright }
                    { send: right }
                ]
            }
        }
        {
            name: move_one_word_left
            modifier: control
            keycode: left
            mode: [emacs, vi_normal, vi_insert]
            event: { edit: movewordleft }
        }
        {
            name: move_one_word_right_or_take_history_hint
            modifier: control
            keycode: right
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: historyhintwordcomplete }
                    { edit: movewordright }
                ]
            }
        }
        {
            name: move_to_line_start
            modifier: none
            keycode: home
            mode: [emacs, vi_normal, vi_insert]
            event: { edit: movetolinestart }
        }
        {
            name: move_to_line_start
            modifier: control
            keycode: char_a
            mode: [emacs, vi_normal, vi_insert]
            event: { edit: movetolinestart }
        }
        {
            name: move_to_line_end_or_take_history_hint
            modifier: none
            keycode: end
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: historyhintcomplete }
                    { edit: movetolineend }
                ]
            }
        }
        {
            name: move_to_line_end_or_take_history_hint
            modifier: control
            keycode: char_e
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: historyhintcomplete }
                    { edit: movetolineend }
                ]
            }
        }
        {
            name: move_to_line_start
            modifier: control
            keycode: home
            mode: [emacs, vi_normal, vi_insert]
            event: { edit: movetolinestart }
        }
        {
            name: move_to_line_end
            modifier: control
            keycode: end
            mode: [emacs, vi_normal, vi_insert]
            event: { edit: movetolineend }
        }
        {
            name: move_up
            modifier: control
            keycode: char_p
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: menuup }
                    { send: up }
                ]
            }
        }
        {
            name: move_down
            modifier: control
            keycode: char_t
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: menudown }
                    { send: down }
                ]
            }
        }
        {
            name: delete_one_character_backward
            modifier: none
            keycode: backspace
            mode: [emacs, vi_insert]
            event: { edit: backspace }
        }
        {
            name: delete_one_word_backward
            modifier: control
            keycode: backspace
            mode: [emacs, vi_insert]
            event: { edit: backspaceword }
        }
        {
            name: delete_one_character_forward
            modifier: none
            keycode: delete
            mode: [emacs, vi_insert]
            event: { edit: delete }
        }
        {
            name: delete_one_character_forward
            modifier: control
            keycode: delete
            mode: [emacs, vi_insert]
            event: { edit: delete }
        }
        {
            name: delete_one_character_backward
            modifier: control
            keycode: char_h
            mode: [emacs, vi_insert]
            event: { edit: backspace }
        }
        {
            name: delete_one_word_backward
            modifier: control
            keycode: char_w
            mode: [emacs, vi_insert]
            event: { edit: backspaceword }
        }
        {
            name: move_left
            modifier: none
            keycode: backspace
            mode: vi_normal
            event: { edit: moveleft }
        }
        {
            name: newline_or_run_command
            modifier: none
            keycode: enter
            mode: emacs
            event: { send: enter }
        }
        {
            name: move_left
            modifier: control
            keycode: char_b
            mode: emacs
            event: {
                until: [
                    { send: menuleft }
                    { send: left }
                ]
            }
        }
        {
            name: move_right_or_take_history_hint
            modifier: control
            keycode: char_f
            mode: emacs
            event: {
                until: [
                    { send: historyhintcomplete }
                    { send: menuright }
                    { send: right }
                ]
            }
        }
        {
            name: redo_change
            modifier: control
            keycode: char_g
            mode: emacs
            event: { edit: redo }
        }
        {
            name: undo_change
            modifier: control
            keycode: char_z
            mode: emacs
            event: { edit: undo }
        }
        {
            name: paste_before
            modifier: control
            keycode: char_y
            mode: emacs
            event: { edit: pastecutbufferbefore }
        }
        {
            name: cut_word_left
            modifier: control
            keycode: char_w
            mode: emacs
            event: { edit: cutwordleft }
        }
        {
            name: cut_line_to_end
            modifier: control
            keycode: char_k
            mode: emacs
            event: { edit: cuttoend }
        }
        {
            name: cut_line_from_start
            modifier: control
            keycode: char_u
            mode: emacs
            event: { edit: cutfromstart }
        }
        {
            name: swap_graphemes
            modifier: control
            keycode: char_t
            mode: emacs
            event: { edit: swapgraphemes }
        }
        {
            name: move_one_word_left
            modifier: alt
            keycode: left
            mode: emacs
            event: { edit: movewordleft }
        }
        {
            name: move_one_word_right_or_take_history_hint
            modifier: alt
            keycode: right
            mode: emacs
            event: {
                until: [
                    { send: historyhintwordcomplete }
                    { edit: movewordright }
                ]
            }
        }
        {
            name: move_one_word_left
            modifier: alt
            keycode: char_b
            mode: emacs
            event: { edit: movewordleft }
        }
        {
            name: move_one_word_right_or_take_history_hint
            modifier: alt
            keycode: char_f
            mode: emacs
            event: {
                until: [
                    { send: historyhintwordcomplete }
                    { edit: movewordright }
                ]
            }
        }
        {
            name: delete_one_word_forward
            modifier: alt
            keycode: delete
            mode: emacs
            event: { edit: deleteword }
        }
        {
            name: delete_one_word_backward
            modifier: alt
            keycode: backspace
            mode: emacs
            event: { edit: backspaceword }
        }
        {
            name: delete_one_word_backward
            modifier: alt
            keycode: char_m
            mode: emacs
            event: { edit: backspaceword }
        }
        {
            name: cut_word_to_right
            modifier: alt
            keycode: char_d
            mode: emacs
            event: { edit: cutwordright }
        }
        {
            name: upper_case_word
            modifier: alt
            keycode: char_u
            mode: emacs
            event: { edit: uppercaseword }
        }
        {
            name: lower_case_word
            modifier: alt
            keycode: char_l
            mode: emacs
            event: { edit: lowercaseword }
        }
        {
            name: capitalize_char
            modifier: alt
            keycode: char_c
            mode: emacs
            event: { edit: capitalizechar }
        }
        {
            name: copy_selection
            modifier: control_shift
            keycode: char_c
            mode: emacs
            event: { edit: copyselection }
        }
        {
            name: cut_selection
            modifier: control_shift
            keycode: char_x
            mode: emacs
            event: { edit: cutselection }
        }
        {
            name: select_all
            modifier: control_shift
            keycode: char_a
            mode: emacs
            event: { edit: selectall }
        }
    ]
}

def --env cx [arg] {
    cd $arg
    ls -l
}

alias l = ls --all
alias c = clear
alias ll = ls -l
alias lt = eza --tree --level=2 --long --icons --git
alias v = nvim
alias as = aerospace
alias asr = atuin scripts run

def ff [] {
    aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

source ~/.config/nushell/env.nu

let ruby_ver = "3.4.0"
let gem_home = ($nu.home-path | path join ".gem" "ruby" $ruby_ver)
let gem_bin = ($gem_home | path join "bin")

# Set GEM paths
$env.GEM_HOME = $gem_home
$env.GEM_PATH = $gem_home

# Add gem bin to PATH if it exists
if ($gem_bin | path exists) {
  $env.PATH = ($env.PATH | prepend $gem_bin)
}
$env.DIRENV_LOG_FORMAT = ""

# For the VPN utility
source ~/.config/nushell/vpn.nu
source $"($nu.home-path)/.cargo/env.nu"

# Disable Nushell's default prompt indicators (let Starship handle it)
$env.PROMPT_INDICATOR = {|| "" }
$env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "" }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }
