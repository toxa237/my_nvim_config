local dap = require("dap")

-- шукає python інтерпретер в момент запуску дебагу (не при завантаженні nvim)
local function find_python()
  -- 1. активований venv ($VIRTUAL_ENV встановлюється при source activate)
  local venv = os.getenv("VIRTUAL_ENV")
  if venv and vim.fn.executable(venv .. "/bin/python") == 1 then
    return venv .. "/bin/python"
  end
  -- 2. шукаємо venv в кореневій папці проекту (типові назви)
  local cwd = vim.fn.getcwd()
  for _, name in ipairs({ ".venv", "venv", "env", ".env" }) do
    local path = cwd .. "/" .. name .. "/bin/python"
    if vim.fn.executable(path) == 1 then
      return path
    end
  end
  -- 3. системний python
  return "python3"
end

-- adapter налаштовується mason-nvim-dap автоматично (через debugpy з mason)
-- тут лише переозначуємо configurations щоб pythonPath був динамічним
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = find_python, -- функція, викликається при кожному запуску
    cwd = "${workspaceFolder}",
  },
}
