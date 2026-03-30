return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        {
            '<leader>rr',
            function() require('refactoring').select_refactor() end,
            mode = { 'n', 'v' },
            desc = 'Select refactor',
        },
    },
    config = true,
}
