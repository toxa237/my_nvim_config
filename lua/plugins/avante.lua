return {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    lazy = false,
    version = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },

    opts = {
        provider = "ollama",
        providers = {
            ollama = {
                endpoint = "http://127.0.0.1:11434",
                model = "llama3",
                api_type = "chat",
                temperature = 0.1,
                max_tokens = 8192,
            },
        },
    },
}
