vim.pack.add({ { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
})

vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        require("nvim-autopairs").setup({})

        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
})
