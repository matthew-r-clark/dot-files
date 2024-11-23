return {
    'tpope/vim-fugitive',
    config = function()
        local map = vim.api.nvim_set_keymap

        map('', '<leader>gd', ':Gvdiff<CR>', { desc = 'git diff' })
        map('', '<leader>gb', ':Git blame<CR>', { desc = 'git blame' })
        map('', '<leader>gs', ':Git<CR>', { desc = 'git status'})
    end
}
