return { -- vim syntax theme (Nord)
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    init = function ()
        vim.cmd(':colorscheme nordfox')
    end,
    opts = {
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
    },
}
