return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        vim.g.neo_tree_remove_legacy_commands = 1
        require("neo-tree").setup({
            close_if_last_window = false,   -- важливо: не закривати Neo-tree при зміні табів
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = false,
            filesystem = {
                follow_current_file = {
                    enabled = true,            -- true коли перемикаєш вкладку → дерево підлаштовується
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
                    ".gitigrore"
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
}

