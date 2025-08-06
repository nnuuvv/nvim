return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", lazy = true },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- NOTE: "opts = {}" is the same as calling "require('fidget').setup({})"
        { "j-hui/fidget.nvim",       opts = {} },
        -- "hrsh7th/cmp-nvim-lsp",
        "simrat39/rust-tools.nvim"
    },

    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

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
        }

        require('mason').setup()

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'stylua', -- used to format lua code
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {
            ensure_installed = {},
            automatic_installation = {},
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
            capabilities = capabilities,
            on_attach = function()
                vim.opt.tabstop = 2
            end
        })

        local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1

        local omnisharp_path = ""
        if is_windows then
            omnisharp_path = vim.fs.normalize("~/omnisharp/OmniSharp.exe")
        else
            omnisharp_path = vim.fs.normalize("~/omnisharp/OmniSharp")
        end


        lspconfig.omnisharp.setup({
            cmd = { omnisharp_path, '--languageserver' },
            filetypes = { 'cs', 'razor' },
            root_dir = lspconfig.util.root_pattern('*.sln', 'Directory.Build.props', '.git'),
            capabilities = capabilities,
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
        })
    end,
}
