return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            { path = "luvit-meta/library", lazy = true },
        },
    },
    dependencies = {
        { "Bilal2453/luvit-meta", lazy = true },
    }
}
