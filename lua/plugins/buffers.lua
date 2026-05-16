return {
    -- bufferline (tabs)
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        version = "*",
        config = function()
            local bufferline = require('bufferline')
            bufferline.setup({
                options = {
                    -- separator_style = "slant",
                    diagnostics = "nvim_lsp",
                },
                highlights = {
                    fill = {
                        bg = "none",
                    },
                }
            })
        end
    },
    {
        "echasnovski/mini.bufremove",
        version = false,
        config = function()
            require("mini.bufremove").setup({})
        end,
        keys = {
            {
                "<leader>x",
                function()
                    local bd = require("mini.bufremove").delete
                    bd(0, false)
                end,
                desc = "Delete Buffer safely",
            },
        },
    },
}
