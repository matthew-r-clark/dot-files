return { -- vim syntax theme (Nord)
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    config = function ()
        require('nightfox').setup({
            options = {
                transparent = true,
                dim_inactive = false,
                styles = {
                    keywords = 'bold',
                },
            },
            groups = {
                all = {
                    CursorLine = { bg = '#2E3440' },
                    CursorColumn = { bg = '#2E3440' },
                    ColorColumn = { bg = '#2E3440' },
                    TelescopeNormal = { bg = '#181E2A' },
                    TelescopePreviewNormal = { bg = '#181E2A' },
                    TelescopePromptNormal = { bg = '#181E2A' },
                    TelescopeResultsNormal = { bg = '#181E2A' },
                    TelescopeBorder = { bg = '#181E2A' },
                    TelescopePreviewBorder = { bg = '#181E2A' },
                    TelescopePromptBorder = { bg = '#181E2A' },
                    TelescopeResultsBorder = { bg = '#181E2A' },
                },
            },
        })
        vim.cmd(':colorscheme nordfox')
        vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#2E3440' })
        vim.api.nvim_create_autocmd('WinLeave', {
            callback = function() vim.wo.winhighlight = 'Normal:NormalNC' end,
        })
        vim.api.nvim_create_autocmd('WinEnter', {
            callback = function() vim.wo.winhighlight = '' end,
        })
    end,
}
