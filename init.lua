 vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

require("config.lazy")
require("config.keymaps")
require("config.general_setings")

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

vim.opt.clipboard = "unnamedplus"

