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
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            inactive_sections = {
                lualine_c = {},
            },
            winbar = {
                lualine_a = { 'mode' },
                lualine_b = {},
                lualine_c = {
                    {
                        'filename',
                        color = {
                            fg = '#D8DEE9',
                        },
                        path = 1,
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
                lualine_z = { 'location' },
            },
            inactive_winbar = {
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

        vim.opt.ruler = false

        vim.api.nvim_create_autocmd('VimEnter', {
            callback = function()
                -- Full-width winbar background
                vim.api.nvim_set_hl(0, 'WinBar', { bg = '#242935' })
                vim.api.nvim_set_hl(0, 'WinBarNC', { bg = '#383e4a' })
                -- Transparent statusline
                -- vim.api.nvim_set_hl(0, 'StatusLine', { link = 'Normal' })
                -- vim.api.nvim_set_hl(0, 'StatusLineNC', { link = 'NormalNC' })
                vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#181E2A', fg = '#181E2A' })
                vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = '#181E2A', fg = '#181E2A' })
                for _, mode in ipairs({ 'normal', 'insert', 'visual', 'replace', 'command', 'inactive' }) do
                    vim.api.nvim_set_hl(0, 'lualine_c_' .. mode, { bg = 'NONE' })
                end
            end,
        })
    end,
}
