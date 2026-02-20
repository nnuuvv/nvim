vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2

require "nvim-treesitter".install { "gleam" }

vim.api.nvim_create_autocmd('FileType', {
    pattern = { '.gleam' },
    callback = function() vim.treesitter.start() end,
})

vim.treesitter.start()
