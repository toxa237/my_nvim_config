return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function ()
            require("tokyonight").setup({
                transparent = true,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                },
            })
            vim.cmd("colorscheme tokyonight")
        end
    },
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        extra_groups = {
            "NeoTreeNormal",
            "NeoTreeNormalNC",
            "NeoTreeFloatBorder",
            "ToggleTerm1Normal",
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            local ok, lualine = pcall(require, "lualine")
            if ok then
                lualine.setup({
                    options = {
                        theme = "tokyonight",
                        ignore_focus = {},
                    }
                })
            end
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "python",
                    "lua",
                    "bash",
                    "json",
                    "yaml",
                    "html",
                    "css",
                    "javascript",
                    "query",
                    "markdown",
                    "markdown_inline",
                    -- "latex"
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    }
}
