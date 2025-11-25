local opt = vim.opt

opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
