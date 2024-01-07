local map = vim.api.nvim_set_keymap

return { -- fuzzy finder
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzf-native.nvim',
    },
    init = function ()
        map('n', '<leader>p', ':Telescope find_files<cr>', {})
        map('n', '<leader>/', ':Telescope live_grep<cr>', {})
    end,
    opts = function(_, default_opts)
        local actions = require('telescope.actions')

        local custom_opts = {
            defaults = {
                vimgrep_arguments = { -- live_grep()
                    'rg', '--follow', '--color=never', '--no-heading',
                    '--with-filename', '--line-number', '--column', '--smart-case',
                    '--hidden', '--no-ignore',
                    '--glob', '!.git/*',
                    '--glob', '!/node_modules',
                    '--glob', '!.next',
                    '--glob', '!package-lock.json',
                    '--glob', '!projects/**/node_modules',
                    '--glob', '!build-node-docker/node_modules',
                    '--glob', '!build/*',
                    '--glob', '!dist/*',
                    '--glob', '!Session.vim',
                },
                mappings = {
                    i = {
                        ['<esc>'] = actions.close,
                        ['<Tab>'] = actions.move_selection_next,
                        ['<S-Tab>'] = actions.move_selection_previous,
                    }
                },
                prompt_prefix = ' ',
                selection_caret = ' ',
                entry_prefix = '  ',
                initial_mode = 'insert',
                layout_strategy = 'flex',
                layout_config = {
                    width = 0.99,
                    prompt_position = 'bottom',
                    preview_cutoff = 0,
                    horizontal = {
                        preview_width = 0.55,
                        mirror = false
                    },
                    vertical = {
                        mirror = false,
                    }
                },
                set_env = {['COLORTERM'] = 'truecolor'},
            },
            pickers = {
                find_files = {
                    find_command = {
                        'rg', '--hidden', '--files', '--no-ignore',
                        '--glob', '!.git/*',
                        '--glob', '!/node_modules',
                        '--glob', '!.next',
                        '--glob', '!projects/**/node_modules',
                        '--glob', '!build-node-docker/node_modules',
                        '--glob', '!build/*',
                        '--glob', '!dist/*',
                    },
                },
            },
            extensions = {
                file_browser = {
                    follow_symlinks = true,
                    hidden = { file_browser = true, folder_browser = true },
                    no_ignore = true,
                },
            },
        }

        return MERGE_TABLES(default_opts, custom_opts)
    end,
}
