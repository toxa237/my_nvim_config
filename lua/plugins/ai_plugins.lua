return {
    -- {
    --     "yetone/avante.nvim",
    --     build = "make",
    --     event = "VeryLazy",
    --     lazy = false,
    --     version = false,
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "muniftanjim/nui.nvim",
    --         "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    --         "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    --         "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    --         "ibhagwan/fzf-lua", -- for file_selector provider fzf
    --         "stevearc/dressing.nvim", -- for input provider dressing
    --         "folke/snacks.nvim", -- for input provider snacks
    --         "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons        },
    --     },
    --         opts = {
    --         provider = "ollama",
    --         providers = {
    --             ollama = {
    --                 __inherited_from = "openai",
    --                 endpoint = "http://127.0.0.1:11434/v1",
    --                 model = "qwen3.5:4b",
    --                 api_key_name = "",
    --             },
    --         },
    --     },
    -- },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            { 'stevearc/dressing.nvim', opts = {} },
        },
        config = function()
            require("codecompanion").setup({
                display = {
                    chat = {
                        show_settings = true,
                        window = {
                            layout = "vertical",
                            relative = "editor",
                            width = 0.35,
                            position = "right",
                        },
                    },
                    diff = {
                        enabled = true,
                        close_chat_at = 240,
                        layout = 'vertical',
                        opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
                        provider = 'default'
                    },
                },
                adapters = {
                    http = {
                        my_ollama = function()
                            return require("codecompanion.adapters").extend("openai_compatible", {
                                env = {
                                    url = "http://127.0.0.1:11434",
                                    api_key = "ollama",
                                },
                                schema = {
                                    model = {
                                        default = "carstenuhlig/omnicoder-2-9b:latest",
                                    },
                                    temperature = {
                                        default = 0.6,
                                    },
                                },
                            })
                        end,
                    },
                },
                strategies = {
                    chat   = { adapter = "my_ollama" },  -- <- slash notation
                    inline = { adapter = "my_ollama" },
                    agent  = { adapter = "my_ollama" },
                },
                opts = {
                    send_code = true,
                    use_diagnostic_signs = true,
                },
            })

            vim.keymap.set({ "n", "v" }, "<leader>a", "", { desc = "AI" })
            vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI Chat" })
            vim.keymap.set("n", "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "AI Inline" })
            vim.keymap.set("v", "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "AI Inline" })
            vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "AI Actions" })
        end,
    },
    {
        'milanglacier/minuet-ai.nvim',
        config = function()
            require('minuet').setup {
                virtualtext = {
                    auto_trigger_ft = {},
                    keymap = {
                        accept = '<A-A>',
                        accept_line = '<A-a>',
                        accept_n_lines = '<A-z>',
                        prev = '<A-[>',
                        next = '<A-]>',
                        dismiss = '<A-e>',
                    },
                },
                provider = 'openai_fim_compatible',
                provider_options = {
                    openai_fim_compatible = {
                        api_key = 'TERM',
                        name = 'Ollama',
                        end_point = 'http://localhost:11434/v1/completions',
                        model = 'qwen2.5-coder:7b',
                        optional = {
                            max_tokens = 256,
                            top_p = 0.9,
                        },
                    },
                },
            }
        end,
    }
}
