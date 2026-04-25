return {
    "gelguy/wilder.nvim",
    dependencies = { "romgrk/fzy-lua-native" },
    config = function()
        require("config.wilder")
    end,
}
