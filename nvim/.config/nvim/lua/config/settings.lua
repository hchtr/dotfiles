local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Behaviour
opt.autoread = true
opt.shortmess:append("I")
opt.mouse = "a"
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.splitright = true
opt.splitbelow = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.expandtab = false

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.wildmenu = true
opt.termguicolors = true
vim.cmd.colorscheme("habamax")

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
