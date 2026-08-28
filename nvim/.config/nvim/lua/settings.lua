local opt = vim.opt

vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
opt.autoread = true
opt.autochdir = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.expandtab = false

opt.wildmenu = true

opt.number = true
opt.relativenumber = true

opt.termguicolors = false
vim.cmd("colo retrobox")

opt.hlsearch = true
opt.incsearch = true
opt.smartcase = true

opt.conceallevel = 2
opt.completeopt = { "menu", "menuone", "noselect" }
