return {

    -- LSP core
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local servers = {
                "lua_ls",
                "ast_grep",
                "cssls",
                "cssmodules_ls",
                "djlsp",
                "golangci_lint_ls",
                "html",
                "jinja_lsp",
                "pyright",
            }
            for _, server in ipairs(servers) do
                vim.lsp.config(server, {
                    capabilities = capabilities,
                })
                vim.lsp.enable(server)
            end
            -- Django
            vim.lsp.config("djlsp", {
                filetypes = { "html", "htmldjango" },
                capabilities = capabilities,
            })
            -- HTML
            vim.lsp.config("html", {
                filetypes = { "html", "htmldjango" },
                capabilities = capabilities,
            })
            -- Emmet
            vim.lsp.config("emmet_ls", {
                filetypes = { "html", "htmldjango", "css" },
                capabilities = capabilities,
            })
            vim.lsp.enable("emmet_ls")

            require("luasnip.loaders.from_vscode").lazy_load({
                include = { "html" },
            })
        end,
    },
    -- Mason installer
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Автокомпліт
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-f>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if cmp.visible_docs() then
                                cmp.close_docs()
                            else
                                cmp.open_docs()
                            end
                        else
                            fallback()
                        end
                    end),
                }),
                sources = cmp.config.sources({
                    { name = "lazydev" },
                    { name = "nvim_lsp" },
                    { name = "path" },
                }, {
                        { name = "buffer" },
                    }),
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
}

