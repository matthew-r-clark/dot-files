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
