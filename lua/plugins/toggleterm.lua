return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_terminals = true,
            direction = 'float',
            insert_mappings = true,
            terminal_mappings = true,
            persist_size = true,
            close_on_exit = true,
        })
    end,
}
