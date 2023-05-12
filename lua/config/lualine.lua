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
                    fg = '#D8DEE9',
                },
            },
        },
        lualine_y = {},
    },
    tabline = {
        lualine_a = {
            {
                'buffers',
                mode = 2, -- shows buffer name + buffer index
                show_filename_only = false,
                buffers_color = {
                    active = { fg = '#2E3440', bg = '#88C0D0' },
                    inactive = { fg = '#2E3440', bg = '#4C566A' },
                },
                max_length = vim.o.columns,
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
})
