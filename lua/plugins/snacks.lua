return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        lazygit = {
            -- uses snacks float defaults, customize if needed
        },
        terminal = {
            -- enable the terminal module for general use later
        },
    },
    keys = {
        { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
    },
}
