return { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = 'InsertEnter',
    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            build = (function()
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                end
                return 'make install_jsregexp'
            end)(),
            dependencies = {
              -- `friendly-snippets` contains a variety of premade snippets.
              --    See the README about individual language/framework/plugin snippets:
              --    https://github.com/rafamadriz/friendly-snippets
              -- {
              --   'rafamadriz/friendly-snippets',
              --   config = function()
              --     require('luasnip.loaders.from_vscode').lazy_load()
              --   end,
              -- },
            },
        },
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
    },
    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        luasnip.config.setup {}

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = 'menu,menuone,noinsert' },
            mapping = cmp.mapping.preset.insert({
                -- select next / previous item
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                -- scroll docs
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                -- confirm selection
                ['<C-Space>'] = cmp.mapping.confirm({ select = true }),

                -- Think of <c-j> as moving to the next bit of your snippet expansion.
                --  So if you have a snippet that's like:
                --  function $name($args)
                --    $body
                --  end
                --
                -- <c-j> will move you to the the next(right) of each of the expansion locations.
                -- <c-k> is similar, except moving you backwards. 
                ['<C-j>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_locally_jump()
                    end
                end, { 'i', 's' }),
                ['<C-k>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),
            }),
            sources = {
                {
                    name = 'lazydev',
                    -- set group index to skipp loading luals completion as lazydev recommends it
                    group_index = 0,
                },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
            },
        }
    end
}
