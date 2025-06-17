-- Leader
--
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic Vim
-- show line number
vim.cmd("set number")
-- tabs are 4 spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- user keymaps
require("config.keymaps")

-- lazy package manager config
require("config.lazy")
