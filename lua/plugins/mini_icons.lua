return {
    {
        "echasnovski/mini.icons",
        opts = {},
        config = function()
            require("mini.icons").setup()
            -- робить сумісним з плагінами що очікують nvim-web-devicons
            require("mini.icons").mock_nvim_web_devicons()
        end,
    }
}
