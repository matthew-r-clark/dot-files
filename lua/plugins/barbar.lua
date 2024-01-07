local function create_keymaps()
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
end

local function set_highlight_groups()
    local function hl(group, options)
        vim.api.nvim_set_hl(0, group, options)
    end

    local currentDefault = {bg='#2E3440', fg='#88C0D0'}
    local visibleDefault = {bg='#2E3440', fg='#D8DEE9'}
    local inactiveDefault = {bg='#4C566A', fg='#2E3440'}
    local alternateDefault = {bg='#4C566A', fg='#5E81AC'}

    local visibleModified = {bg='#2E3440', fg='#B48EAD'}
    local inactiveModified = {bg='#4C566A', fg='#B48EAD'}

    local visibleError = {bg='#2E3440', fg='#BF616A'}
    local inactiveError = {bg='#4C566A', fg='#BF616A'}
    local visibleWarning = {bg='#2E3440', fg='#EBCB8B'}
    local inactiveWarning = {bg='#4C566A', fg='#EBCB8B'}

    hl('BufferTabpageFill', {bg='#4C566A'})

    hl('BufferCurrent', currentDefault)
    hl('BufferCurrentIcon', currentDefault)
    hl('BufferCurrentIndex', currentDefault)
    hl('BufferCurrentMod', visibleModified)
    hl('BufferCurrentSign', currentDefault)
    hl('BufferCurrentTarget', visibleError)
    hl('BufferCurrentERROR', visibleError)
    hl('BufferCurrentWARN', visibleWarning)

    hl('BufferVisible', visibleDefault)
    hl('BufferVisibleIcon', visibleDefault)
    hl('BufferVisibleIndex', visibleDefault)
    hl('BufferVisibleMod', visibleModified)
    hl('BufferVisibleSign', visibleDefault)
    hl('BufferVisibleTarget', visibleError)
    hl('BufferVisibleERROR', visibleError)
    hl('BufferVisibleWARN', visibleWarning)

    hl('BufferInactive', inactiveDefault)
    hl('BufferInactiveIcon', inactiveDefault)
    hl('BufferInactiveIndex', inactiveDefault)
    hl('BufferInactiveMod', inactiveModified)
    hl('BufferInactiveSign', {bg='#4C566A', fg='#434C5E'})
    hl('BufferInactiveTarget', inactiveError)
    hl('BufferInactiveERROR', inactiveError)
    hl('BufferInactiveWARN', inactiveWarning)

    hl('BufferAlternate', alternateDefault)
    hl('BufferAlternateIcon', alternateDefault)
    hl('BufferAlternateIndex', alternateDefault)
    hl('BufferAlternateMod', inactiveModified)
    hl('BufferAlternateSign', alternateDefault)
    hl('BufferAlternateTarget', inactiveError)
    hl('BufferAlternateERROR', inactiveError)
    hl('BufferAlternateWARN', inactiveWarning)
end

local function set_autocmds()
    vim.opt.sessionoptions:append 'globals'
    vim.api.nvim_create_user_command(
      'Mksession',
      function(attr)
        vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'})
        vim.cmd.mksession {bang = attr.bang, args = attr.fargs}
      end,
      {bang = true, complete = 'file', desc = 'Save barbar with :mksession', nargs = '?'}
    )

    local session_group = vim.api.nvim_create_augroup('Setup', { clear = true })
    vim.api.nvim_create_autocmd({ 'VimEnter' }, {
      callback = function()
          set_highlight_groups()
      end,
      group = session_group,
    })
end

return { -- buffer tabs
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
        create_keymaps()
        set_autocmds()
    end,
    opts = {
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
    },
}
