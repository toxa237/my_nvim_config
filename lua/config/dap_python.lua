local dap = require("dap")
local venv = os.getenv("VIRTUAL_ENV") or (vim.fn.getcwd() .. "/.venv")

dap.adapters.python = {
  type = 'executable',
  command = venv .. '/bin/python',
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file (local venv)',
    program = '${file}',
    pythonPath = function()
      return venv .. '/bin/python'
    end,
  },
}

