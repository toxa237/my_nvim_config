return {
  {
    -- сам дебагер: брейкпоінти, кроки, змінні
    "mfussenegger/nvim-dap",
  },
  {
    -- ставить дебагери через Mason (debugpy, delve)
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mason-org/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "delve" },
        automatic_installation = true,
        handlers = {}
      })
      -- override python configurations (pythonPath шукає venv в момент запуску)
      require("config.dap_python")
    end
  },
  {
    -- готові налаштування дебагу для Go
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "go",
    config = function()
      require("config.dap_go")
    end,
  },
  {
    -- панелі дебагера: змінні, стек, watches, консоль
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio", -- async-бібліотека для dap-ui
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui"] = function() dapui.close() end

      vim.fn.sign_define('DapBreakpoint', { text='●', texthl='DapBreakpoint', linehl='', numhl='' })
      vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='DapBreakpointCondition', linehl='', numhl='' })
      vim.fn.sign_define('DapLogPoint', { text='◆', texthl='DapLogPoint', linehl='', numhl='' })
      vim.fn.sign_define('DapStopped', { text='󰁕', texthl='DapStopped', linehl='Visual', numhl='' })
    end
  },
}

