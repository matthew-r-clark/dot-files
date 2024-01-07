return { -- vim syntax theme (Nord)
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    opts = function(_, default_opts)
        vim.cmd(':colorscheme nordfox')

        local custom_opts = {
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
        }

        return MERGE_TABLES(default_opts, custom_opts)
    end
}
