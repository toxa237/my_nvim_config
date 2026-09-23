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
        -- колірна тема
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
                -- overrides = function(colors) -- add/modify highlights
                --     return {}
                -- end,
                theme = "wave",              -- Load "wave" theme
                background = {               -- map the value of 'background' option to a theme
                    dark = "wave",           -- try "dragon" !
                    light = "lotus"
                },
            })
            vim.cmd("colorscheme kanagawa")
        end
    },
    {
        -- прозорий фон
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
        -- статусний рядок унизу
        "nvim-lualine/lualine.nvim",
        config = function()
            local ok, lualine = pcall(require, "lualine")
            if ok then
                lualine.setup({
                    options = {
                        theme = "kanagawa",
                        globalstatus = true,
                        ignore_focus = {},
                        section_separators = { left = '', right = '' },
                        component_separators = { left = '', right = '' },
                    },
                })
            end
        end
    },
    {
        -- розбір коду: підсвітка і відступи для =
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- гілка main: ensure_installed/highlight/indent більше не існують,
            -- парсери ставляться через install(), решта вмикається в autocmd нижче
            require("nvim-treesitter").install({
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
            })
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    if not pcall(vim.treesitter.start) then
                        return
                    end
                    -- indent для `=` тільки якщо для мови є indents.scm, інакше все з'їде в 0
                    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
                    if lang and vim.treesitter.query.get(lang, "indents") then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end
    },
    {
        -- повідомлення справа зверху, : по центру, вікна LSP-документації
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- підказку аргументів показує blink.cmp, інакше буде два вікна
                signature = { enabled = false },
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim", -- UI-бібліотека для noice
            "rcarriga/nvim-notify", -- спливаючі повідомлення
        }
    }
}

