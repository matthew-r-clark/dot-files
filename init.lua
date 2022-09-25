require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use { -- file explorer
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use 'EdenEast/nightfox.nvim'

    use {
        'nvim-lualine/lualine.nvim', -- vim status line theme
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    use 'norcalli/nvim-colorizer.lua' -- highlight color codes
    
    use 'christoomey/vim-sort-motion' -- sort bindings

    use 'easymotion/vim-easymotion' -- find letter

    use 'w0rp/ale' -- prettier
end)

require('nvim-tree').setup({
    open_on_setup = true,
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    hijack_unnamed_buffer_when_opening = true,
    auto_reload_on_write = true,
    reload_on_bufenter = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
        -- ignore_list = [],
    },
    renderer = {
        icons = {
            show = {
                git = true,
            },
        },
    },
    view = {
        adaptive_size = true,
    },
})
require('nvim-web-devicons').setup({ default = true })

require('nightfox').setup({
    options = {
        transparent = true,
        dim_inactive = true,
        styles = {
            keywords = 'bold',
        },
    },
    groups = {
        all = {
            CursorLine = { bg = '#3B4252' },
            CursorColumn = { bg = '#3B4252' },
        },
    },
})

require('lualine').setup({
    options = {
        theme = 'nord',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'NvimTree' },
    },
    sections = {
        lualine_b = {},
        lualine_c = {
            {
                'filename',
                color = {
                    fg = '#2E3440',
                    bg = vim.bo.modified and '#88C0D0' or '#4C566A',
                },
                path = 3,
                shorting_target = 10,
            },
        },
        lualine_x = {
            {
                'filetype',
                icon_only = true,
            },
        },
        lualine_y = {},
    },
    tabline = {
        lualine_a = {
            {
                'buffers',
                mode = 2,
                show_filename_only = false,
                buffers_color = {
                    active = { fg = '#2E3440', bg = '#88C0D0' },
                    inactive = { fg = '#2E3440', bg = '#4C566A' },
                },
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
})

vim.opt.termguicolors = true
require('colorizer').setup({'*'})

local map = vim.api.nvim_set_keymap
map('n', '<leader>1', '<cmd>LualineBuffersJump 1<cr>', {})
map('n', '<leader>2', '<cmd>LualineBuffersJump 2<cr>', {})
map('n', '<leader>3', '<cmd>LualineBuffersJump 3<cr>', {})
map('n', '<leader>4', '<cmd>LualineBuffersJump 4<cr>', {})
map('n', '<leader>5', '<cmd>LualineBuffersJump 5<cr>', {})
map('n', '<leader>6', '<cmd>LualineBuffersJump 6<cr>', {})
map('n', '<leader>7', '<cmd>LualineBuffersJump 7<cr>', {})
map('n', '<leader>8', '<cmd>LualineBuffersJump 8<cr>', {})
map('n', '<leader>9', '<cmd>LualineBuffersJump 9<cr>', {})
map('n', '<leader>0', '<cmd>LualineBuffersJump 10<cr>', {})
map('n', '<leader><leader>1', '<cmd>LualineBuffersJump 11<cr>', {})
map('n', '<leader><leader>2', '<cmd>LualineBuffersJump 12<cr>', {})
map('n', '<leader><leader>3', '<cmd>LualineBuffersJump 13<cr>', {})
map('n', '<leader><leader>4', '<cmd>LualineBuffersJump 14<cr>', {})
map('n', '<leader><leader>5', '<cmd>LualineBuffersJump 15<cr>', {})
map('n', '<leader><leader>6', '<cmd>LualineBuffersJump 16<cr>', {})
map('n', '<leader><leader>7', '<cmd>LualineBuffersJump 17<cr>', {})
map('n', '<leader><leader>8', '<cmd>LualineBuffersJump 18<cr>', {})
map('n', '<leader><leader>9', '<cmd>LualineBuffersJump 19<cr>', {})
map('n', '<leader><leader>0', '<cmd>LualineBuffersJump 20<cr>', {})

vim.cmd('source ~/.vim/.vimrc')
vim.o.showtabline = 2
