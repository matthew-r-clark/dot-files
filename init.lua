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
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    use 'norcalli/nvim-colorizer.lua'
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

require('nightfox')

require('lualine').setup({
    options = {
        theme = 'nord',
    }
})

vim.opt.termguicolors = true
require('colorizer').setup({'*'})

vim.cmd('source ~/.vim/.vimrc')
