return {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        ensure_installed = {
            'bashls',
            'eslint',
            'html',
            'jsonls',
            'lua_ls',
            'tsserver',
            'yamlls',
        },
        automatic_installation = true,
    },
    dependencies = {
        "williamboman/mason.nvim",
        event = { "BufReadPre", "BufNewFile" },
        build = ":MasonUpdate",
        keys = {
            { "<leader>lI", "<cmd>Mason<CR>", desc = "Opens Mason" },
        },
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate", "MasonLog" },
        opts = {}
    },
}
