return { -- vim status line theme
    'nvim-lualine/lualine.nvim',
    dependencies = {
        { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    config = function()
        local theme = require('lualine.themes.nord')
        -- 5% darker than backgrounds
        theme.normal.c.bg = '#242935'
        theme.inactive.c.bg = '#383e4a'

        require('lualine').setup({
            options = {
                theme = theme,
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
            inactive_sections = {
                lualine_c = {
                    {
                        'filename',
                        color = {
                            fg = '#D8DEE9',
                        },
                        path = 3,
                        shorting_target = 10,
                    },
                },
            },
        })
    end,
}
