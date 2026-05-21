return {
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        init = function()
            vim.opt.laststatus = 3
            vim.opt.splitkeep = "screen"
            local pcall_transparent, transparent = pcall(require, "transparent")
            if pcall_transparent then
                transparent.clear_prefix("Edgy")
            end
        end,
        opts = {
            animate = {
                enabled = false,
            },
            bottom = {
                {
                    ft = "toggleterm",
                    size = { height = 0.4 },
                    filter = function(buf, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
            },
            left = {
                {
                    title = "Neo-Tree",
                    ft = "neo-tree",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "filesystem"
                    end,
                    size = { height = 0.5 },
                },
            },
        },
    }
}
