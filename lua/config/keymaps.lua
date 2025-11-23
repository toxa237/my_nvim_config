local map = vim.keymap.set

vim.g.mapleader = " "

-- neo-tree mapings
map("n", "<C-n>", "<Cmd>Neotree toggle<CR>", { desc = "File Explorer" })

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
map('n', '<F5>', function() dap.continue() end)
map('n', '<F10>', function() dap.step_over() end)
map('n', '<F11>', function() dap.step_into() end)
map('n', '<F12>', function() dap.step_out() end)
map('n', '<F9>', function() dap.toggle_breakpoint() end)

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
map("n", "<Space>x", ":bdelete<CR>", { desc = "Close buffer" })
