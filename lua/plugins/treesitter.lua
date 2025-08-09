vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require("nvim-treesitter.configs").setup({
    auto_install = true,
    highlight = {
        enable = true
    }
})
