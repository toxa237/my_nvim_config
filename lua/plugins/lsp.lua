return {

  -- LSP core
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- LSP ключі
      local on_attach = function(_, bufnr)
        local map = vim.keymap.set
        map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
        map("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
        map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
      end

      local lspconfig = require("lspconfig")

      -- Підключаємо встановлені через mason
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "lua_ls" },
        handlers = {
          function(server)
            lspconfig[server].setup {
              on_attach = on_attach,
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
            }
          end,
        },
      })
    end,
  },

  -- Mason installer
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Автокомпліт
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
        },
      })
    end,
  },

}

