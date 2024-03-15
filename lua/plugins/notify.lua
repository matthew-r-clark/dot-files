return {
    "rcarriga/nvim-notify",
    config = function ()
        require('telescope').load_extension('notify');
        require('notify').setup({
            background_colour = '#000000',
        })
    end
}
