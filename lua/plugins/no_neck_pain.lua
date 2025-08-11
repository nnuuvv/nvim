vim.pack.add({ { src = "https://github.com/shortcuts/no-neck-pain.nvim" } })

require("no-neck-pain").setup({
    width = 150,
    buffers = {
        right = {
            -- disable right buffer
            enabled = false,
        },
        colors = {
            background = "catppuccin-frappe-dark",
        },
        -- make left scratch pad
        scratchPad = {
            enabled = true,
            location = "./scratch_pad/",
        },
        bo = {
            filetype = "md"
        },
    },
    autocmds = {
        enableOnVimEnter = true,
    },
})
