return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_terminals = false,
            -- highlights = {
            --     Normal = {
            --         guibg = "#00FF00",
            --     }
            -- },
            -- direction = 'float', --horizontal, float
            insert_mappings = true,
            terminal_mappings = true,
            persist_size = true,
            close_on_exit = true,
        })
    end,
}
