return {
    {
        -- визначає корінь проєкту, cd в нього, список проєктів
        'DrKJeff16/project.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'wsdjeg/picker.nvim',
            'folke/snacks.nvim',
            'ibhagwan/fzf-lua',
        },
        config = function ()
            require("project").setup({
                manual_mode=true
            })
        end
    },
    {
        -- підхоплює python venv для pyright
        "jglasovic/venv-lsp.nvim",
        config = function()
            print("Venv-LSP: Plugin loading...")
            require("venv-lsp").setup()
        end,
    },
    {
        -- зберігає/відновлює сесію (відкриті файли)
        "folke/persistence.nvim",
        lazy = false,
        config = function (_, opts)
            local persistence = require("persistence")
            persistence.setup(opts)

            -- вмикає збереження сесії тільки якщо поточна папка є в списку проєктів
            local function sync()
                local projects = require("project.util.history").get_recent_projects(true)
                if vim.list_contains(projects, vim.fn.getcwd()) then
                    persistence.start()
                else
                    persistence.stop()
                end
            end

            vim.opt.sessionoptions:append("globals")
            -- перед збереженням: запамʼятати, чи відкритий neo-tree, і закрити його
            vim.api.nvim_create_autocmd("User", {
                pattern = "PersistenceSavePre",
                callback = function()
                    local open = 0
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "neo-tree" then
                            open = 1
                        end
                    end
                    vim.g.NeoTreeOpen = open
                    vim.cmd("Neotree close")
                end,
            })
            -- після завантаження: відкрити neo-tree, якщо він був відкритий
            vim.api.nvim_create_autocmd("User", {
                pattern = "PersistenceLoadPost",
                callback = function()
                    if vim.g.NeoTreeOpen == 1 then
                        vim.cmd("Neotree show")
                    end
                end,
            })


            vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
                callback = sync,
            })
        end
    },
}

