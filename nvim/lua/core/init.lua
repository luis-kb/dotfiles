-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.signcolumn = "number"


-- Tabs and spaces
vim.opt.expandtab = true
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 4

-- Text width and ruler
vim.opt.textwidth = 78
vim.opt.colorcolumn = "75,80"


-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true


-- Infinite undos
vim.opt.undofile = true


require("core.remaps");
