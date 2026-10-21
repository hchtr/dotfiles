local opt = vim.opt

opt.autoread = true
opt.shortmess:append("I")

opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.expandtab = false

opt.wildmenu = true

opt.number = true
opt.relativenumber = true

opt.termguicolors = true 
vim.cmd("colo lunaperche")

opt.hlsearch = true
opt.incsearch = true
opt.smartcase = true

opt.conceallevel = 2
opt.completeopt = { "menu", "menuone", "noselect" }

vim.g.mapleader = " "
vim.g.maplocalleader = " "
