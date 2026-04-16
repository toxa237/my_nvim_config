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
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {
            options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" }
        }
    },
 }
