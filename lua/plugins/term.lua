vim.pack.add({ { src = "https://github.com/akinsho/toggleterm.nvim" } })

require("toggleterm").setup({
    open_mapping = [[<c-t>]],
    autochdir = true,
    direction = "float", -- "vertical" | "horizontal" | "tab" | "float"
})
