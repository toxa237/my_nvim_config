local opt = vim.opt

opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
opt.number = true
opt.relativenumber = true
opt.tabstop = 4

opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

