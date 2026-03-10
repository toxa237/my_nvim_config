return {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },

    opts = {
        provider = "ollama",
        providers = {
            ollama = {
                endpoint = "http://127.0.0.1:11434",
                model = "deepseek-coder:6.7b",
                api_type = "chat",
                temperature = 0.1,
                max_tokens = 8192,
            },
        },
    },
}
