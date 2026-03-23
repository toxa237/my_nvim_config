local opt = vim.opt

opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
opt.number = true
opt.relativenumber = true
opt.tabstop = 4

opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

vim.api.nvim_set_hl(0, "NeoTreeTabActive", { fg = "#7aa2f7", bold = true }) -- Текст "Files" (наприклад, фіолетовий)
vim.api.nvim_set_hl(0, "NeoTreeTabInactive", { fg = "#565f89" }) -- Неактивні вкладки
vim.api.nvim_set_hl(0, "NeoTreeTabSeparatorActive", { fg = "none", bg = "none" }) --  фон "Files"
vim.api.nvim_set_hl(0, "NeoTreeTabSeparatorInactive", { fg = "none", bg = "none" })
--
-- vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#7aa2f7", bold = true })
-- vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#a9b1d6" })
-- vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#7aa2f7" })
-- vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#3f7806" })
-- vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#519e03" })


-- django coments
vim.api.nvim_create_autocmd("FileType", {
    pattern = "htmldjango",
    callback = function()
        vim.bo.commentstring = "{# %s #}"
    end,
})

