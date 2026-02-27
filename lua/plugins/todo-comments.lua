-- Available keywords:
--     FIX
--     TODO
--     HACK
--     WARN
--     PERF
--     NOTE
--     TEST

return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {
            '<leader>tc',
            '<cmd>TodoTelescope<cr>',
            desc = 'view todo comments',
        },
    },
    opts = {},
}
