return {
    {
        "echasnovski/mini.icons",
        opts = {},
        config = function()
            require("mini.icons").setup()
            require("mini.icons").mock_nvim_web_devicons()

            -- local function dim_mini_icons(factor)
            --     local groups = {
            --         "MiniIconsAzure", "MiniIconsBlue", "MiniIconsCyan",
            --         "MiniIconsGreen", "MiniIconsGrey", "MiniIconsOrange",
            --         "MiniIconsPurple", "MiniIconsRed", "MiniIconsYellow", "MiniIconsWhite",
            --     }
            --     for _, name in ipairs(groups) do
            --         local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
            --         if hl.fg then
            --             local hex = string.format("%06x", hl.fg)
            --             local r = math.floor(tonumber(hex:sub(1, 2), 16) * factor)
            --             local g = math.floor(tonumber(hex:sub(3, 4), 16) * factor)
            --             local b = math.floor(tonumber(hex:sub(5, 6), 16) * factor)
            --             hl.fg = r * 65536 + g * 256 + b
            --             vim.api.nvim_set_hl(0, name, hl)
            --         end
            --     end
            -- end
            --
            -- vim.api.nvim_create_autocmd("ColorScheme", {
            --     callback = function() dim_mini_icons(0.65) end,
            -- })
            -- dim_mini_icons(0.65)
        end,
    }
}
