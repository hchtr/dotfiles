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

vim.g.netrw_banner = 0       
vim.g.netrw_browse_split = 4 
vim.g.netrw_winsize = 20     
vim.g.netrw_altv = 1

vim.opt.conceallevel = 2
