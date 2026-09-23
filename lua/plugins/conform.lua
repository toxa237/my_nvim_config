-- Форматування коду (самі форматери ставить Mason, див. lsp.lua)
return {
    "stevearc/conform.nvim",
    keys = {
        {
            "<leader>mf",
            function()
                require("conform").format({ async = true })
            end,
            desc = "Format file",
        },
    },
    opts = {
        formatters_by_ft = {
            python = { "ruff_format" },
            lua = { "stylua" },
            go = { "goimports" },
        },
        -- для інших мов пробує форматувати через LSP
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
}
