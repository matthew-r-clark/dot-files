return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
        image = {
            doc = {
                enabled = true,
                inline = true,
                float = true,
                max_width = 80,
                max_height = 40,
            },
        },
    },
}
