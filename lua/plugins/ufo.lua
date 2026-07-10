return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
            vim.opt.foldenable = true
            require("ufo").setup({
                provider_selector = function()
                    return { "lsp", "indent" }
                end,
            })
        end,
    }
}
