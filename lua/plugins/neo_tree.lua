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
          enabled = true,            -- коли перемикаєш вкладку → дерево підлаштовується
        },
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
      },

      buffers = {
        follow_current_file = {
	  enabled = true,
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

