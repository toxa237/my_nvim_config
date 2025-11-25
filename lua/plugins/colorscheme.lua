return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        integration = {
	  cmp = true,
          gitsigns = true,
          nvimtree = true,
	  neotree = true,
	  barbar = true,
	  mason = true,
	  telescope = {
	      enabled = true,
	  },
	  which_key = true,
        }
      })
      vim.cmd.colorscheme("catppuccin-mocha")
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = { theme = "catppuccin" }
      })
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
