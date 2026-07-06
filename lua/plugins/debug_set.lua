return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
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
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "go",
    config = function()
      require("config.dap_go")
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
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

