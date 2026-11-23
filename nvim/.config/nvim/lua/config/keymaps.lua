local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Keep selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Diagnostics
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })
