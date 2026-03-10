return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.05,
      },
      transparent_background = false,
      integrations = {
          cmp = true,
          dap = true,
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
      vim.cmd.colorscheme("catppuccin-macchiato")
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
