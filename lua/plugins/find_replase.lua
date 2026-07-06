return {
    {
        "MagicDuck/grug-far.nvim",
        config = function()
            require("grug-far").setup({
                windowCreationCommand = "rightbelow vsplit",
            })
        end,
        keys = {
            {
                "<leader>fr",
                function() require("grug-far").open() end,
                desc = "Search & Replace",
            },
        },
    }
}
