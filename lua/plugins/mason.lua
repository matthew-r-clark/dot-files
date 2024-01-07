local language_servers = require('constants').language_servers

return {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        ensure_installed = language_servers,
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
