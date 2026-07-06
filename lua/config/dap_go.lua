require("dap-go").setup({
  dap_configurations = {
    {
      type = "go",
      name = "Debug current file",
      request = "launch",
      program = "${file}",
    },
    {
      type = "go",
      name = "Debug package",
      request = "launch",
      program = "${fileDirname}", -- увесь пакет в папці поточного файлу
    },
    {
      type = "go",
      name = "Debug with args",
      request = "launch",
      program = "${fileDirname}",
      args = function()
        local args = vim.fn.input("Args: ")
        return vim.split(args, " ", { trimempty = true })
      end,
    },
  },
})
