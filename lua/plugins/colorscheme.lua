return {
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function ()
    --         require("tokyonight").setup({
    --             transparent = true,
    --             styles = {
    --                 sidebars = "transparent",
    --                 floats = "transparent",
    --             },
    --         })
    --         vim.cmd("colorscheme tokyonight-storm")
    --     end
    -- },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        prioryty = 1000,
        config = function ()
            require('kanagawa').setup({
                compile = false,             -- enable compiling the colorscheme
                undercurl = true,            -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true},
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false,         -- do not set background color
                dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
                terminalColors = true,       -- define vim.g.terminal_color_{0,17}
                colors = {                   -- add/modify theme and palette colors
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function(colors) -- add/modify highlights
                    return {}
                end,
                theme = "wave",              -- Load "wave" theme
                background = {               -- map the value of 'background' option to a theme
                    dark = "wave",           -- try "dragon" !
                    light = "lotus"
                },
            })

            -- setup must be called before loading
            vim.cmd("colorscheme kanagawa")
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
                        theme = "kanagawa",
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
            require("nvim-treesitter.config").setup({
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
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
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

