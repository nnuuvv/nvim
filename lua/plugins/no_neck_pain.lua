return {
    "shortcuts/no-neck-pain.nvim",
    opts = {
        width = 150,
        buffers = {
            right = {
                -- disable right buffer
                enabled = false,
            },
            -- make left scratch pad
            scratchPad = {
                enabled = true,
                location = "./scratch_pad/",
            },
        },
        bo = {
            filetype = "md"
        },
        autocmds = {
            enableOnVimEnter = true,
        },
    },
}
