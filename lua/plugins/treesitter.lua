vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("nvim-treesitter.configs").setup({
    auto_install = true,
    highlight = {
        enable = true
    }
})
