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
                    separator_style = "slant",
                    diagnostics = "nvim_lsp",
                },
                highlights = {
                    fill = {
                        bg = '#121212',
                    },
                }
            })
        end
    },
}
