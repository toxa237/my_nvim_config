return {
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                patterns = {
                    "pyproject.toml",
                    "requirements.txt",
                    "manage.py",
                    ".venv",
                    "venv",
                    ".git"
                },
                update_cwd = true,
            }
        end
    },


    {
        "jglasovic/venv-lsp.nvim",
        config = function()
            require("venv-lsp").setup()
        end,
    },

    {
        "rmagatti/auto-session",
        lazy = true,
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            log_level = "error",
            auto_save_enabled = true,
            auto_restore_enabled = true,
        },
    }
}
