local map = vim.keymap.set

return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    init = function()
        map('n', '<leader>o', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', {})
    end,
    config = function()
        require('telescope').load_extension('file_browser')
    end,
}
