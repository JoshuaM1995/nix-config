-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local act = wezterm.action

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Catppuccin Mocha'
local scheme = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]

-- When wezterm cli emit is implemented, uncomment this
-- wezterm.on('sol-start', function(cmd)
--     -- Create a new window
--     local tab, pane1, window = mux.spawn_window {}

--     -- Pane 1: Top-left
--     pane1:send_text('cd ~/Development/sol-intelligence/sol-backend && sw\n')

--     -- Pane 2: Top-right
--     local pane2 = pane1:split{
--         direction = 'Right',
--         size = 0.5
--     }
--     pane2:send_text('cd ~/Development/sol-intelligence/sol-backend && bw\n')

--     -- Pane 3: Bottom-left
--     local pane3 = pane1:split{
--         direction = 'Bottom',
--         size = 0.5
--     }
--     pane3:send_text('cd ~/Development/sol-intelligence/sol-scheduling-portal && y dev\n')

--     -- Pane 4: Bottom-right
--     local pane4 = pane2:split{
--         direction = 'Bottom',
--         size = 0.5
--     }
--     pane4:send_text('cd ~/Development/sol-intelligence/sol-employee-app && y dev\n')
-- end)

local config = {
    color_schemes = {
        ['Catppuccin Mocha'] = scheme
    },
    color_scheme = 'Catppuccin Mocha',
    font = wezterm.font("FiraCode Nerd Font Mono"),
    font_size = 13,
    -- enable_tab_bar = false,
    window_decorations = "RESIZE",
    window_padding = {
        left = '1cell',
        right = '1cell',
        top = '1cell',
        bottom = '1cell'
    },
    -- window_background_opacity = 0.9,
    -- macos_window_background_blur = 30,
    use_fancy_tab_bar = false,
    scrollback_lines = 25000,
    enable_scroll_bar = true,
    cursor_thickness = 1,
    cursor_blink_rate = 1000,
    default_cursor_style = 'BlinkingBar',
    colors = {
        tab_bar = {
            -- The color of the tab bar background
            background = "#1E1E2F", -- Background color for the entire tab bar
            -- The color of the inactive tabs
            inactive_tab = {
                bg_color = "#1e1e2e", -- Background color of inactive tabs
                fg_color = "#c0caf5" -- Foreground color (text color) of inactive tabs
            },
            -- The color of the active tab
            active_tab = {
                bg_color = "#b4befe", -- Background color of the active tab
                fg_color = "#1e1e2e" -- Foreground color (text color) of the active tab
            }
        },
        copy_mode_active_highlight_fg = {
            Color = '#c0caf5'
        },
        copy_mode_active_highlight_bg = {
            Color = '#1E1E2F'
        },
        copy_mode_inactive_highlight_fg = {
            Color = '#1E1E2F'
        },
        copy_mode_inactive_highlight_bg = {
            Color = '#b4befe'
        }
    },
    -- background = {{
    --     source = {
    --         -- File = '/Users/joshuamcnabb/Pictures/Wallpapers/catppuccin-wallpapers/flatppuccin/flatppuccin_4k_macchiato.png'
    --         -- File = '/Users/joshuamcnabb/Pictures/Wallpapers/catppuccin-wallpapers/misc/doggocat.png'
    --         File = '/Users/joshuamcnabb/Pictures/Wallpapers/catppuccin-wallpapers/minimalistic/hashtags-black.png'
    --         -- File = '/Users/joshuamcnabb/Pictures/Wallpapers/catppuccin-wallpapers/misc/cat-sound.png'
    --     },
    --     width = '100%',
    --     height = '100%'
    -- }, {
    --     source = {
    --         Color = 'rgba(35, 39, 58, 0.9)'
    --     },
    --     width = '100%',
    --     height = '100%'
    -- }},
    keys = { -- Navigate to the next tab 
    {
        key = ']',
        mods = 'CTRL',
        action = act.ActivateTabRelative(1)
    }, -- Navigate to the previous tab
    {
        key = '[',
        mods = 'CTRL',
        action = act.ActivateTabRelative(-1)
    }, -- Clear terminal output with CMD + K
    {
        key = 'k',
        mods = 'CMD',
        action = wezterm.action.ClearScrollback('ScrollbackAndViewport')
    }, {
        key = "f",
        mods = "CMD",
        action = wezterm.action_callback(function(window, pane)
            window:perform_action(act.Search({
                CaseInSensitiveString = ''
            }), pane)
            window:perform_action(act.Multiple {act.CopyMode 'ClearPattern', act.CopyMode 'ClearSelectionMode',
                                                act.CopyMode 'MoveToScrollbackBottom'}, pane)
        end)
    }, -- {
    --     key = 'f',
    --     mods = 'CTRL',
    --     action = act.SpawnCommandInNewWindow {
    --         args = {'/opt/homebrew/bin/fzf', '--no-sort', '--no-mouse', '--exact', '-i', '--tac'}
    --     }
    -- }, 
    {
        key = 'LeftArrow',
        mods = 'CMD',
        action = wezterm.action.SendString '\x01' -- Ctrl+A (Go to the beginning of the line)
    }, -- CMD + Right Arrow: Go to the end of the line
    {
        key = 'RightArrow',
        mods = 'CMD',
        action = wezterm.action.SendString '\x05' -- Ctrl+E (Go to the end of the line)
    }, -- CTRL + Left Arrow: Go to the previous word
    {
        key = 'LeftArrow',
        mods = 'ALT',
        action = wezterm.action.SendString '\x1bb' -- Escape + b (Back one word)
    }, -- Option + Right Arrow: Move to the next word
    {
        key = 'RightArrow',
        mods = 'ALT',
        action = wezterm.action.SendString '\x1bf' -- Escape + f (Forward one word)
    }, -- CMD + Backspace: Delete the entire line
    {
        key = 'Backspace',
        mods = 'CMD',
        action = wezterm.action.SendString '\x15' -- Ctrl+U (Delete entire line)
    }, {
        key = 'Backspace',
        mods = 'ALT',
        action = wezterm.action.SendString '\x1b\x7f' -- ESC + DEL
    }, -- CMD + D: Split pane vertically (side-by-side)
    {
        key = 'd',
        mods = 'CMD',
        action = wezterm.action.SplitHorizontal {
            domain = 'CurrentPaneDomain'
        }
    }, -- CMD + SHIFT + D: Split pane horizontally (stacked)
    {
        key = 'd',
        mods = 'CMD|SHIFT',
        action = wezterm.action.SplitVertical {
            domain = 'CurrentPaneDomain'
        }
    }, -- CMD + W: Close the current pane (like iTerm2)
    {
        key = 'w',
        mods = 'CMD',
        action = wezterm.action.CloseCurrentPane {
            confirm = false
        }
    }, -- CMD + Option + ArrowKey: Navigate between panes
    {
        key = 'LeftArrow',
        mods = 'CTRL|OPT',
        action = wezterm.action.ActivatePaneDirection 'Left'
    }, {
        key = 'RightArrow',
        mods = 'CTRL|OPT',
        action = wezterm.action.ActivatePaneDirection 'Right'
    }, {
        key = 'UpArrow',
        mods = 'CTRL|OPT',
        action = wezterm.action.ActivatePaneDirection 'Up'
    }, {
        key = 'DownArrow',
        mods = 'CTRL|OPT',
        action = wezterm.action.ActivatePaneDirection 'Down'
    }},
    key_tables = {
        search_mode = { -- Enter: Go to the next search result
        {
            key = 'Enter',
            mods = '',
            action = wezterm.action.CopyMode 'NextMatch'
        }, -- Shift + Enter: Go to the previous search result
        {
            key = 'Enter',
            mods = 'SHIFT',
            action = wezterm.action.CopyMode 'PriorMatch'
        }, -- Escape: Exit search mode
        {
            key = 'Escape',
            mods = '',
            action = wezterm.action.CopyMode 'Close'
        }}
    }
}

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
    options = {
        icons_enabled = true,
        theme = 'Catppuccin Mocha',
        color_overrides = {
            -- Default colors from Catppuccin Mocha
            normal_mode = {
                a = {
                    fg = '#181825',
                    bg = '#cba6f7'
                },
                b = {
                    fg = '#cba6f7',
                    bg = '#313244'
                },
                c = {
                    fg = '#cdd6f4',
                    bg = '#181825'
                }
            },
            copy_mode = {
                a = {
                    fg = '#181825',
                    bg = '#f9e2af'
                },
                b = {
                    fg = '#f9e2af',
                    bg = '#313244'
                },
                c = {
                    fg = '#cdd6f4',
                    bg = '#181825'
                }
            },
            search_mode = {
                a = {
                    fg = '#181825',
                    bg = '#a6e3a1'
                },
                b = {
                    fg = '#a6e3a1',
                    bg = '#313244'
                },
                c = {
                    fg = '#cdd6f4',
                    bg = '#181825'
                }
            },
            -- Defining colors for a new key table
            window_mode = {
                a = {
                    fg = '#181825',
                    bg = '#89b4fa'
                },
                b = {
                    fg = '#89b4fa',
                    bg = '#313244'
                },
                c = {
                    fg = '#cdd6f4',
                    bg = '#181825'
                }
            },
            -- Default tab colors
            tab = {
                active = {
                    fg = '#cba6f7',
                    bg = '#313244'
                },
                inactive = {
                    fg = '#cdd6f4',
                    bg = '#181825'
                },
                inactive_hover = {
                    fg = '#e4ceff',
                    bg = '#313244'
                }
            }
        },
        section_separators = {
            left = wezterm.nerdfonts.pl_left_hard_divider,
            right = wezterm.nerdfonts.pl_right_hard_divider
        },
        component_separators = {
            left = wezterm.nerdfonts.pl_left_soft_divider,
            right = wezterm.nerdfonts.pl_right_soft_divider
        },
        tab_separators = {
            left = wezterm.nerdfonts.pl_left_hard_divider,
            right = wezterm.nerdfonts.pl_right_hard_divider
        }
    },
    sections = {
        tabline_a = {'mode'},
        tabline_b = {'workspace'},
        tabline_c = {' '},
        tab_active = {'index', {
            'parent',
            padding = 0
        }, '/', {
            'cwd',
            padding = {
                left = 0,
                right = 1
            }
        }, {
            'zoomed',
            padding = 0
        }},
        tab_inactive = {'index', {
            'process',
            padding = {
                left = 0,
                right = 1
            }
        }},
        tabline_x = {'ram', 'cpu'},
        -- tabline_y = {
        --     'datetime',
        --     -- options: your own format string ('%Y/%m/%d %H:%M:%S', etc.)
        --     style = '%I:%M:%S %p',
        --     hour_to_icon = {
        --         ['00'] = wezterm.nerdfonts.md_clock_time_twelve_outline,
        --         ['01'] = wezterm.nerdfonts.md_clock_time_one_outline,
        --         ['02'] = wezterm.nerdfonts.md_clock_time_two_outline,
        --         -- for every hour...
        --         ['23'] = wezterm.nerdfonts.md_clock_time_eleven
        --     }
        --     -- hour_to_icon is a table that maps hours to icons it overwrites the default icon property.
        --     -- To use the default icon property set hour_to_icon to nil.
        --     -- The color and align properties can still be used on the icon property.
        -- },
        tabline_x = {},
        tabline_y = {},
        tabline_z = {'hostname'}
    },
    extensions = {}
})
tabline.apply_to_config(config)

-- CTRL + ALT + P: Toggle presentation mode
wezterm.plugin.require("https://gitlab.com/xarvex/presentation.wez").apply_to_config(config, {
    font_weight = "DemiBold", -- active font weight for both modes
    font_size_multiplier = 1.5 -- multiplier for font size for both modes
})

return config
