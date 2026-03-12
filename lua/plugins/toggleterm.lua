return {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
        local toggleterm = require('toggleterm')
        local Terminal = require('toggleterm.terminal').Terminal

        toggleterm.setup({
            size = function(term)
                if term.direction == 'float' then
                    return 0
                end
            end,
            float_opts = {
                border = 'rounded',
                width = math.floor(vim.o.columns * 0.9),
                height = math.floor(vim.o.lines * 0.9),
            },
            direction = 'float',
        })

        local lazygit  = Terminal:new({ cmd = 'lazygit' })
        local posting  = Terminal:new({ cmd = 'posting' })
        local lazydocker = Terminal:new({ cmd = 'lazydocker' })
        local claude   = Terminal:new({ cmd = 'claude' })

        vim.keymap.set('n', '<leader>fg', function() lazygit:toggle() end,   { desc = 'Lazygit' })
        vim.keymap.set('n', '<leader>fp', function() posting:toggle() end,   { desc = 'posting (http client)' })
        vim.keymap.set('n', '<leader>fd', function() lazydocker:toggle() end, { desc = 'lazy docker' })
        vim.keymap.set('n', '<leader>fc', function() claude:toggle() end,    { desc = 'claude' })
    end,
}
