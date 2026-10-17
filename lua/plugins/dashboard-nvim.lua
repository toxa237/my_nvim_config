return {
    {
        -- стартовий екран, коли nvim відкрито без файлу
        'goolord/alpha-nvim',
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            -- лого: NEO, Tux, VIM
            -- кожна "колонка" це список рядків, кольори з палітри kanagawa
            local function letters(...)
                local out = {}
                for row = 1, 6 do
                    local parts = {}
                    for _, l in ipairs({ ... }) do
                        parts[#parts + 1] = l[row]
                    end
                    out[row] = table.concat(parts, " ")
                end
                return out
            end
            local N = { "███╗   ██╗", "████╗  ██║", "██╔██╗ ██║", "██║╚██╗██║", "██║ ╚████║", "╚═╝  ╚═══╝" }
            local E = { "███████╗", "██╔════╝", "█████╗  ", "██╔══╝  ", "███████╗", "╚══════╝" }
            local O = { " ██████╗ ", "██╔═══██╗", "██║   ██║", "██║   ██║", "╚██████╔╝", " ╚═════╝ " }
            local V = { "██╗   ██╗", "██║   ██║", "██║   ██║", "╚██╗ ██╔╝", " ╚████╔╝ ", "  ╚═══╝  " }
            local I = { "██╗", "██║", "██║", "██║", "██║", "╚═╝" }
            local M = { "███╗   ███╗", "████╗ ████║", "██╔████╔██║", "██║╚██╔╝██║", "██║ ╚═╝ ██║", "╚═╝     ╚═╝" }

            local columns = {
                { hl = "LogoNeo", lines = letters(N, E, O) },
                { hl = "LogoTux", lines = {
                    [[     .--.     ]],
                    [[    |o_o |    ]],
                    [[    |:_/ |    ]],
                    [[   //   \ \   ]],
                    [[  (|     | )  ]],
                    [[ /'\_   _/`\  ]],
                    [[ \___)=(___/  ]],
                } },
                { hl = "LogoVim", lines = letters(V, I, M) },
            }

            vim.api.nvim_set_hl(0, "LogoNeo", { fg = "#7E9CD8" })   -- crystalBlue
            vim.api.nvim_set_hl(0, "LogoTux", { fg = "#E6C384" })   -- carpYellow
            vim.api.nvim_set_hl(0, "LogoVim", { fg = "#98BB6C" })   -- springGreen

            -- склеюємо колонки в рядки (по нижньому краю) + рахуємо, де який колір (в байтах)
            local height = 0
            for _, col in ipairs(columns) do
                height = math.max(height, #col.lines)
            end
            local header, header_hl = {}, {}
            for row = 1, height do
                local line, hls = "", {}
                for _, col in ipairs(columns) do
                    local width = 0
                    for _, l in ipairs(col.lines) do
                        width = math.max(width, vim.fn.strdisplaywidth(l))
                    end
                    local text = col.lines[row - (height - #col.lines)] or ""
                    text = text .. string.rep(" ", width - vim.fn.strdisplaywidth(text)) .. " "
                    hls[#hls + 1] = { col.hl, #line, #line + #text }
                    line = line .. text
                end
                header[row] = line
                header_hl[row] = hls
            end


            dashboard.section.header.val = header
            dashboard.section.header.opts.hl = header_hl
            -- :Telescope projects, але після вибору ще й відновлює сесію (якщо є)
            local function open_project_with_session()
                local actions = require("telescope.actions")
                require("telescope").extensions.projects.projects({
                    attach_mappings = function(prompt_bufnr)
                        actions.select_default:replace(function()
                            local dir = require("telescope.actions.state").get_selected_entry().value
                            actions.close(prompt_bufnr)
                            vim.cmd.cd(dir)

                            local persistence = require("persistence")
                            if vim.fn.filereadable(persistence.current()) == 1 then
                                persistence.load()
                            else
                                require("telescope.builtin").find_files()
                            end
                        end)
                        return true
                    end,
                })
            end

            -- dashboard.button вміє тільки команду-рядок для <CR> на кнопці,
            -- тому функцію ставимо і на клавішу, і на on_press
            local projects_button = dashboard.button("p", "📁 Projects", open_project_with_session)
            projects_button.on_press = open_project_with_session

            dashboard.section.buttons.val = {
                projects_button,
                dashboard.button("P", "📂 Projects (without session)", ":Telescope projects<CR>"),
                dashboard.button("f", "🔍 Find file", ":Telescope find_files<CR>"),
                dashboard.button("q", "❌ Quit", ":qa<CR>"),
            }
            alpha.setup(dashboard.config)
        end,
    }
}
