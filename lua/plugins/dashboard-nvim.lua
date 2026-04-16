return {
    {
        'goolord/alpha-nvim',
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            dashboard.section.header.val = {
                "  nvim",
            }
            dashboard.section.buttons.val = {
                dashboard.button("p", "📁 Projects", ":Telescope projects<CR>"),
                dashboard.button("s", "🔄 Restore Session", [[<cmd>lua require("persistence").load()<cr>]]),
                dashboard.button("f", "🔍 Find file", ":Telescope find_files<CR>"),
                dashboard.button("q", "❌ Quit", ":qa<CR>"),
            }
            alpha.setup(dashboard.config)
        end,
    }
}
