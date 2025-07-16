-- Leader
--
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic Vim
-- show line number
vim.cmd("set number")
-- tabs are 4 spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- ignore case in search unless using caps
vim.cmd("set ignorecase")
vim.cmd("set smartcase")

-- recognize .S asm as arm
vim.filetype.add {
  extension = {
    -- treat .S (preprocessed ASM) as ARM/Thumb
    S = "arm",
  },
}

-- user keymaps
require("config.keymaps")

-- lazy package manager config
require("config.lazy")
