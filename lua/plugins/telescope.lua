return {
    {
        'nvim-telescope/telescope.nvim', tag = 'v0.1.9',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            defaults = {
                file_ignore_patterns = {
                    "__pycache__",
                    "%.ipynb_checkpoints",
                },
                -- rg аргументи для live_grep/grep_string
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--no-ignore",
                    "--glob", "!__pycache__",
                    "--glob", "!.ipynb_checkpoints",
                },
            },
            pickers = {
                find_files = {
                    no_ignore = true,  -- включати gitignored у пошук файлів
                    hidden = false,    -- але крапкові файли не показувати
                },
            },
        },
    }
}
