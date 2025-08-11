vim.pack.add({ { src = "https://github.com/folke/which-key.nvim" } })
require("which-key").setup({
    spec = {
        { '<leader>c', group = '[C]ode',     mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>f', group = '[F]ile' },
        { '<leader>e', group = '[E]rror' },
        { '<leader>p', group = '[P]ack' },
    },
})
