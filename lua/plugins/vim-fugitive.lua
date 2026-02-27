return {
    'tpope/vim-fugitive',
    config = function()
        local map = vim.api.nvim_set_keymap

        map('', '<leader>gd', ':Gvdiff<CR>', { desc = 'git diff' })
        map('', '<leader>gb', ':Git blame<CR>', { desc = 'git blame' })
        map('', '<leader>gs', ':Git<CR>', { desc = 'git status'})
        map('', '<leader>gm', ':Gdiffsplit!<CR>', { desc = 'git merge tool' })
        map('', '<leader>gl', ':diffget //2<CR>', { desc = 'git merge: take THEIR changes (left)' })
        map('', '<leader>gr', ':diffget //3<CR>', { desc = 'git merge: take YOUR changes (right)' })
    end
}
