return {
    {
        -- пошук і заміна по всьому проєкту
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
