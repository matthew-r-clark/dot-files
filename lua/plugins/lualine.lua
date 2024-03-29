return { -- vim status line theme
    'nvim-lualine/lualine.nvim',
    dependencies = {
        { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    opts = {
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
                        fg = '#D8DEE9',
                        bg = '#4C566A',
                    },
                    path = 3,
                    shorting_target = 10,
                },
            },
            lualine_x = {
                {
                    'branch',
                    color = {
                        fg = '#B48EAD',
                    },
                },
            },
            lualine_y = {},
        },
    },
}
