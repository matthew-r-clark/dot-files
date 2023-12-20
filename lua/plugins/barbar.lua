return { -- buffer tabs
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    opts = function(_plugin, default_opts)
        require('setup/barbar')

        local custom_opts = {
            icons = {
                buffer_index = false,
                button = '',
                separator = {left = '▌', right = ''},
                inactive = {
                    separator = {left = '▏', right = ''}
                },
                visible = {
                    separator = {left = '▏', right = ''}
                },
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = {enabled = true, icon = '✘'},
                    [vim.diagnostic.severity.WARN] = {enabled = true, icon = '▲'},
                },
                gitsigns = {
                    added = {enabled = true, icon = '+'},
                    changed = {enabled = true, icon = '~'},
                    deleted = {enabled = true, icon = '-'},
                },
                filetype = {
                    enabled = true,
                    custom_colors = true,
                },
            },
        }

        return merge_tables(default_opts, custom_opts)
    end,
    init = function()
        local map = vim.api.nvim_set_keymap

        map('n', '<leader>j', ':BufferMovePrevious<cr>', {})
        map('n', '<leader>k', ':BufferMoveNext<cr>', {})
        map('n', '<leader>[', ':BufferPrevious<cr>', {})
        map('n', '<leader>]', ':BufferNext<cr>', {})

        map('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', {})
        map('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', {})
        map('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', {})
        map('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', {})
        map('n', '<leader>5', '<Cmd>BufferGoto 5<CR>', {})
        map('n', '<leader>6', '<Cmd>BufferGoto 6<CR>', {})
        map('n', '<leader>7', '<Cmd>BufferGoto 7<CR>', {})
        map('n', '<leader>8', '<Cmd>BufferGoto 8<CR>', {})
        map('n', '<leader>9', '<Cmd>BufferGoto 9<CR>', {})

        map('n', '<C-p>', ':BufferPick<cr>', {})
        map('n', '<C-c>', ':BufferClose<cr>', {})

        vim.opt.sessionoptions:append 'globals'
        vim.api.nvim_create_user_command(
          'Mksession',
          function(attr)
            vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'})
            vim.cmd.mksession {bang = attr.bang, args = attr.fargs}
          end,
          {bang = true, complete = 'file', desc = 'Save barbar with :mksession', nargs = '?'}
        )
    end,
}
