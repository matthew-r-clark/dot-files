return {
    "3rd/image.nvim",
    build = false,
    ft = { "markdown", "quarto", "vimwiki" },
    opts = {
        backend = "kitty",
        kitty_method = "normal",
        editor_only_render_when_focused = true,
        window_overlap_clear_enabled = true,
        tmux_show_only_in_active_window = true,
        integrations = {
            markdown = {
                enabled = true,
                clear_in_insert_mode = true,
                download_remote_images = true,
                only_render_image_at_cursor = true,
                filetypes = { "markdown", "vimwiki" }, --
            },
        },
    },
    config = function(_, opts)
        require('image').setup(opts)

        -- image.nvim's clear() does not properly send the tmux passthrough sequence,
        -- so we send the raw Kitty graphics delete command ourselves.
        vim.api.nvim_create_autocmd({ "BufHidden", "FocusLost" }, {
            callback = function()
                io.write('\x1bPtmux;\x1b\x1b_Ga=d;\x1b\\\x1b\\')
                io.flush()
            end,
        })
    end,
}
