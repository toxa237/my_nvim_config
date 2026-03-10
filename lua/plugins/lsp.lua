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
      -- local on_attach = function(_, bufnr)
      --   local map = vim.keymap.set
      --   -- map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
      --   map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
      -- end

      local lspconfig = require("lspconfig")

      -- Підключаємо встановлені через mason
      require("mason-lspconfig").setup({
        ensure_installed = {
            "lua_ls",
            "ast_grep",
            "cssls",
            "cssmodules_ls",
            "djlsp",
            "golangci_lint_ls",
            "html",
            "jinja_lsp",
            "pyright",
        },
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
		  ["<C-Space>"] = cmp.mapping.complete(),
		  ["<C-f>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
			  if cmp.visible_docs() then
				cmp.close_docs()
			  else
				cmp.open_docs()
			  end
			else
			  fallback()
			end
		  end),
        }),
        sources = cmp.config.sources({
            { name = "lazydev" },
            { name = "nvim_lsp" },
            { name = "path" },
        }, {
            { name = "buffer" },
        }),
      })
    end,
  },

}

