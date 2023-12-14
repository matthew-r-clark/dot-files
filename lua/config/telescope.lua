local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.load_extension('fzf')

telescope.init({
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
})
