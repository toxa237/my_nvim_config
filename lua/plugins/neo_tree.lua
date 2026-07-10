return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "echasnovski/mini.icons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            require("neo-tree").setup({
                close_if_last_window = false,
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = false,
                default_component_configs = {
                    icon = {
                        provider = function(icon, node)
                            local mini = require("mini.icons")
                            if node.type == "directory" then
                                local glyph, hl = mini.get("directory", node.name)
                                icon.text = glyph
                                icon.highlight = hl
                            elseif node.type == "file" then
                                local glyph, hl = mini.get("file", node.name)
                                icon.text = glyph
                                icon.highlight = hl
                            end
                        end,
                    },
                },
                filesystem = {
                    follow_current_file = {
                        enabled = true,
                        leave_dirs_open = true,
                    },
                    bind_to_cwd = true,
                    group_empty_dirs = false,
                    use_libuv_file_watcher = true,
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_ignored = false,
                    hide_hidden = false,
                    never_show = {
                        ".git",
                        ".ipynb_checkpoints",
                        "__pycache__",
                    },
                    always_show = {
                        ".gitignore"
                    },
                },
                sources = {
                    'filesystem',
                    'buffers',
                },
                source_selector = {
                    winbar = true,
                    sources = {
                        { source = 'filesystem' },
                        { source = 'buffers' },
                    },
                },
                window = {
                    position = "left",
                    width = 32,
                },
            })
        end
    },
}

