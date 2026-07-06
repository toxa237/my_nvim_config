return {
    {
        "uga-rosa/ccc.nvim",
        config = function()
            require("ccc").setup({
                highlighter = {
                    auto_enable = false, -- вимикаємо щоб не конфліктувало з LSP
                },
            })
            vim.keymap.set("n", "<leader>cp", "<cmd>CccPick<cr>", { desc = "Color Picker" })
        end,
    },
}
