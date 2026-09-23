return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("mason").setup()
            -- форматери/лінтери (ensure_installed нижче ставить тільки LSP)
            local mason_registry = require("mason-registry")
            mason_registry.refresh(function()
                for _, tool in ipairs({ "ruff", "stylua", "goimports" }) do
                    local ok, pkg = pcall(mason_registry.get_package, tool)
                    if ok and not pkg:is_installed() then
                        pkg:install()
                    end
                end
            end)
            mason_lspconfig.setup({
                ensure_installed = {
                    "lua_ls", "pyright", "ts_ls", "html", "cssls", "emmet_ls", "djlsp", "gopls", "clangd"
                },
                handlers = {
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                ["djlsp"] = function()
                    lspconfig.djlsp.setup({
                        capabilities = capabilities,
                        filetypes = { "html", "htmldjango" },
                    })
                end,
                ["emmet_ls"] = function()
                    lspconfig.emmet_ls.setup({
                        capabilities = capabilities,
                        filetypes = { "html", "htmldjango", "css", "scss" },
                    })
                end,
                },
            })
        end,
    },
    -- vim API для lua_ls
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    -- Автокомпліт
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "rcarriga/cmp-dap",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                enabled = function()
                    return vim.nvim_buf_get_option(0, "buftype") ~= "prompt"
                    or require("cmp_dap").is_dap_buffer()
                end,
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
                    { name = "dap" },
                    { name = "lazydev" },
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "luasnip" },
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

