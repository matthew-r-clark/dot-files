return {
    'numToStr/FTerm.nvim',
    config = function()
        local FTerm = require('FTerm')

        FTerm.setup({
            border = 'rounded',
            dimensions = {
                height = 0.9,
                width = 0.9,
            },
        })

        local lazygit = FTerm:new({ cmd = 'lazygit' })
        local posting = FTerm:new({ cmd = 'posting' })
        local lazydocker = FTerm:new({ cmd = 'lazydocker' })
        local claude = FTerm:new({ cmd = 'claude' })

        vim.keymap.set('n', '<leader>fg', function() lazygit:toggle() end, { desc = 'Lazygit' })
        vim.keymap.set('n', '<leader>fp', function() posting:toggle() end, { desc = 'posting (http client)' })
        vim.keymap.set('n', '<leader>fd', function() lazydocker:toggle() end, { desc = 'lazy docker' })
        vim.keymap.set('n', '<leader>fc', function() claude:toggle() end, { desc = 'claude' })
    end,
}
