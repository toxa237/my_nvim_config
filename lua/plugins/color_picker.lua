return {
    {
        -- підсвітка кольорів (#ff0000) і вибір кольору
        "uga-rosa/ccc.nvim",
        config = function()
            require("ccc").setup({
                highlighter = {
                    auto_enable = true,
                    lsp = false,
                    filetypes = {},
                },
            })
            vim.keymap.set("n", "<leader>cp", "<cmd>CccPick<cr>", { desc = "Color Picker" })
        end,
    },
}
