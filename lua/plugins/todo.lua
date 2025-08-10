vim.pack.add({
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
})

require("todo-comments").setup({})

vim.keymap.set("n", "<leader>tt", ":TodoTelescope<CR>", { desc = "TodoTelescope" })
vim.keymap.set("n", "<leader>tl", ":TodoLocList<CR>", { desc = "TodoLocList" })
