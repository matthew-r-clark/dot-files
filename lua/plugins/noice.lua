return { -- UI for messages, cmdline and the popupmenu
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        cmdline = {
            format = {
                cmdline = {
                    icon = ':',
                },
                search_down = {
                    view = 'cmdline_popup',
                    icon = '/',
                },
                search_up = {
                    view = 'cmdline_popup',
                    icon = '?',
                },
            },
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        { "rcarriga/nvim-notify", opts = { background_colour = "#000000" } },
    }
}
