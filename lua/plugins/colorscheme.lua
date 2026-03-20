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
    local ok, lualine = pcall(require, "lualine")
    if ok then
      lualine.setup({
        options = {
          theme = "catppuccin-macchiato",
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
        "markdown",
        "markdown_inline",
        -- "latex"
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
