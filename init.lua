 vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

vim.opt.encoding = "utf-8"
vim.scriptencoding = "utf-8"

require("config.lazy")
require("config.keymaps")
require("config.general_setings")

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

vim.opt.clipboard = "unnamedplus"


-- vim.cmd([[
--   highlight Normal guibg=NONE
--   highlight NormalNC guibg=NONE
--   highlight EndOfBuffer guibg=NONE
-- ]])

