return {
    {
        'DrKJeff16/project.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'wsdjeg/picker.nvim',
            'folke/snacks.nvim',
            'ibhagwan/fzf-lua',
        },
        opts = {},
        config = function ()
            require("project").setup(

            )
        end
    },
    {
        "jglasovic/venv-lsp.nvim",
        config = function()
            require("venv-lsp").setup()
        end,
    },
    -- {
    --     "rmagatti/auto-session",
    --     lazy = true,
    --     ---@module "auto-session"
    --     ---@type AutoSession.Config
    --     opts = {
    --         log_level = "error",
    --         auto_save_enabled = true,
    --         auto_restore_enabled = true,
    --     },
    -- }
}
