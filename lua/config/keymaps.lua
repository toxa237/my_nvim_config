local map = vim.keymap.set

vim.g.mapleader = " "

-- telescope mapings
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- which key
require('which-key')

-- debaging
local dap = require("dap")
map("n", "<F5>", function() dap.continue() end)
map("n", "<F9>", function() dap.toggle_breakpoint() end)
map("n", "<F10>", function() dap.step_over() end)
map("n", "<F11>", function() dap.step_into() end)
map("n", "<F12>", function() dap.step_out() end)

-- завершити дебаг
map("n", "<F4>", function() dap.terminate() end)

-- перезапустити
map("n", "<leader>dr", function()
  dap.terminate()
  dap.run_last()
end)

local dap = require("dap")
local vscode = require("dap.ext.vscode")

local function debug_with_config()
    local path = vim.fn.getcwd() .. "/.vscode/launch.json"
    if vim.fn.filereadable(path) == 0 then
        vim.fn.mkdir(vim.fn.getcwd() .. "/.vscode", "p")
        local file = io.open(path, "w")
        local template = [[
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Current File",
      "type": "",
      "request": "launch",
      "program": "${file}",
      "args": [],
      "console": "integratedTerminal",
    }
  ]
}]]
        file:write(template)
        file:close()
        vim.cmd("edit " .. path)
    else
        vscode.load_launchjs(nil, {
            python = {'python'},
            cppdbg = {'cpp', 'c'},
            delve = {'go'}
        })
        dap.continue()
    end
end
map("n", "<F6>", debug_with_config)

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- For terminal splits (optional)
map("t", "<C-h>", [[<C-\><C-N><C-w>h]])
map("t", "<C-j>", [[<C-\><C-N><C-w>j]])
map("t", "<C-k>", [[<C-\><C-N><C-w>k]])
map("t", "<C-l>", [[<C-\><C-N><C-w>l]])

-- Tabs / buffers
map("n", "<Tab>", ":BufferLineCycleNext<CR>")
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
map('n', '<leader>>', '<cmd>BufferLineMoveNext<cr>', {desc = 'Move Buffer Right'})
map('n', '<leader><', '<cmd>BufferLineMovePrev<cr>', {desc = 'Move Buffer Left' })

map("n", "gd", vim.lsp.buf.definition)

local function close_buffer_and_neotree()
    local neotree_was_open = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, "filetype")
        if ft == "neo-tree" then
            neotree_was_open = true
            vim.cmd("Neotree close")
            break
        end
    end
    vim.cmd("bdelete")
    if neotree_was_open then
        vim.cmd("Neotree toggle")
    end
end
map("n", "<leader>x",
    close_buffer_and_neotree,
    { noremap = true, silent = true, desc = "Close buffer and reopen Neotree" }
)

-- tree mapings
map("n", "<C-n>", "<Cmd>Neotree toggle<CR>", { desc = "File Explorer" })

-- show diagnostic
map("n", "gh", function()
  vim.diagnostic.open_float(nil, { focus = true })
end)

-- lazy git
map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" } )

-- avante
map("n", "<leader>as", function()
  vim.fn.jobstart("ollama serve", { detach = true })
  vim.notify("🧠 Ollama started")
end, { desc = "Start Ollama" })

map("n", "<leader>ak", function()
  vim.fn.jobstart("pkill ollama")
  vim.notify("💀 Ollama stopped")
end, { desc = "Stop Ollama" })


