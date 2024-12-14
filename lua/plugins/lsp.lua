return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", lazy = true },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- NOTE: "opts = {}" is the same as calling "require('fidget').setup({})"
        { "j-hui/fidget.nvim",       opts = {} },
        "hrsh7th/cmp-nvim-lsp",
        "simrat39/rust-tools.nvim"
    },

    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                -- Function to map specific lsp related items
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

                map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

                map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclartion')


                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = true })

                    -- Highlight references of the word under cursor when cursor rests for a little while
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    -- Clear highlights when cursor moves again
                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    -- handle LspDetach
                    vim.api.nvim_create_autocmd({ 'LspDetach' }, {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end

                -- Add keymap to toggle inlay_hints
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local servers = {
            lua_ls = {
                -- cmd = {...},
                -- filetypes = {...},
                -- capabilities = {},
                settings = {
                    Lua = {
                        completion = {
                            callSnipped = 'Replace',
                        },
                        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                        -- diagnostics = { disable = { 'missing-fields' } },
                    },
                },
            },
            rust_analyzer = {
                settings = {
                    ['rust_analyzer'] = {
                        cargo = {
                            allFeatures = true,
                        },
                    },
                },
            },
            omnisharp = {
                settings = {
                    FormattingOptions = {
                        EnableEditorConfigSupport = true,
                        OrganizeImports = true,
                    },
                    MsBuild = {
                        LoadProjectsOnDemand = nil,
                    },
                    RoslynExtensionsOptions = {
                        EnableImportCompletion = true,
                        AnalyzeOpenDocumentsOnly = nil,
                    },
                    Sdk = {
                        IncludePrereleases = true,
                    },
                },
            },
        }

                require('mason').setup()

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'stylua', -- used to format lua code
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- this handles overriding values configured above
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        }

        -- setup servers not available through mason
        local lspconfig = require('lspconfig')
        lspconfig.gleam.setup({
            cmd = { "gleam", "lsp" },
            filetypes = { "gleam" },
            root_dir = lspconfig.util.root_pattern("gleam.toml", ".git"),
            capabilities = capabilities,
        })


    end,
}
