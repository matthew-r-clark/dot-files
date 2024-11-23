local map = vim.api.nvim_set_keymap

return { -- fuzzy finder
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
        { 'nvim-telescope/telescope-file-browser.nvim' },
        { 'nvim-telescope/telescope-node-modules.nvim' },
        { 'debugloop/telescope-undo.nvim' },
    },
    init = function ()
        map('n', '<leader>tp', ':Telescope find_files<cr>', { desc = 'find files' })
        map('n', '<leader>to', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { desc = 'file browser' })
        map('n', '<leader>t/', ':Telescope live_grep<cr>', { desc = 'global search' })
        map('n', '<leader>td', ':Telescope diagnostics<cr>', { desc = 'diagnostics' })
        map('n', '<leader>tb', ':Telescope buffers<cr>', { desc = 'buffers' })
        map('n', '<leader>tm', ':Telescope notify<cr>', { desc = 'messages' })
        map('n', '<leader>tu', ':Telescope undo<cr>', { desc = 'undo' })
        map('n', '<leader>tn', ':Telescope node_modules list<cr>', { desc = 'node_modules' })
        map('n', '<leader>tg', ':Telescope git_status<cr>', { desc = 'git status' })
    end,
    opts = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions');

        telescope.setup({
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
                    '--glob', '!.eslintcache',
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
        })

        telescope.load_extension('file_browser')
        telescope.load_extension('fzf')
        telescope.load_extension('node_modules')
        telescope.load_extension('undo')
    end,
}
