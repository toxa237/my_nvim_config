return {
    {
        -- встановлювач LSP/дебагерів/форматерів (:Mason)
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        -- LSP: помилки, перехід до визначення, rename, hover
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim", -- ставить LSP з ensure_installed і сам їх вмикає
        },
        config = function()
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

            -- свої налаштування серверів (решта береться з дефолтів nvim-lspconfig).
            -- capabilities для автокомпліту blink.cmp додає сам
            vim.lsp.config("djlsp", {
                filetypes = { "html", "htmldjango" },
            })
            vim.lsp.config("emmet_ls", {
                filetypes = { "html", "htmldjango", "css", "scss" },
            })

            -- встановлює сервери і вмикає всі, що стоять через Mason (automatic_enable)
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls", "pyright", "ts_ls", "html", "cssls", "emmet_ls", "djlsp", "gopls", "clangd"
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
        "saghen/blink.cmp",
        version = "1.*", -- з версією качається готовий бінарник для fuzzy-пошуку
        dependencies = {
            "rafamadriz/friendly-snippets", -- набір готових сніпетів
            -- адаптер, щоб працювали старі cmp-джерела (потрібен для cmp-dap)
            { "saghen/blink.compat", version = "2.*", opts = {} },
            "rcarriga/cmp-dap", -- джерело автокомпліту для dap-repl
        },
        opts = {
            -- dap-repl має buftype=prompt, тому його дозволяємо окремо
            enabled = function()
                return vim.bo.buftype ~= "prompt" or require("cmp_dap").is_dap_buffer()
            end,
            keymap = {
                preset = "none",
                ["<CR>"] = { "accept", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-Space>"] = { "show", "fallback" },
                ["<C-e>"] = { "hide", "fallback" },
                -- показати/сховати документацію
                ["<C-f>"] = { "hide_documentation", "show_documentation", "fallback" },
            },
            completion = {
                -- перший пункт виділений, але текст не вставляється, поки не натиснеш <CR>
                list = { selection = { preselect = true, auto_insert = false } },
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
            },
            -- підказка аргументів функції, як у pycharm/vscode
            signature = { enabled = true },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                per_filetype = {
                    ["dap-repl"] = { "dap" },
                    dapui_watches = { "dap" },
                    dapui_hover = { "dap" },
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100, -- vim.* вище за інше в lua
                    },
                    dap = { name = "dap", module = "blink.compat.source" },
                },
            },
        },
    },
    {
        -- автоматично закриває/перейменовує html-теги
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
}

