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
            print("Venv-LSP: Plugin loading...")
            require("venv-lsp").setup()
        end,
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        lazy = false,
        opts = {
            hooks = {
                select = function()
                    return require("telescope.builtin").find_files {
                        cwd = require("persistence").get_dir(),
                        prompt_title = "Sessions",
                    }
                end,
            },
        },
        keys = {
            {
                "<leader>qs",
                function()
                    require("persistence").load()
                end,
                desc = "Load session for current directory",
            },
            {
                "<leader>qS",
                function()
                    require("persistence").select()
                end,
                desc = "Select session to load",
            },
            {
                "<leader>ql",
                function()
                    require("persistence").load { last = true }
                end,
                desc = "Load last session",
            },
            {
                "<leader>qd",
                function()
                    require("persistence").stop()
                end,
                desc = "Stop persistence",
            },
        },
    },
}
