return {
    -- {
    --     "yetone/avante.nvim",
    --     build = "make",
    --     event = "VeryLazy",
    --     lazy = false,
    --     version = false,
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         "stevearc/dressing.nvim",
    --         -- "nvim-lua/plenary.nvim",
    --         -- "MunifTanjim/nui.nvim",
    --     },
    --     opts = {
    --         provider = "ollama",
    --         providers = {
    --             ollama = {
    --                 __inherited_from = "openai",
    --                 endpoint = "http://127.0.0.1:11434/v1",
    --                 model = "qwen2.5-coder:7b",
    --                 api_key_name = "",
    --             },
    --         },
    --     },
    -- },
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
