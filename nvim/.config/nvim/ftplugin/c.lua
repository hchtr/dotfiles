vim.api.nvim_set_keymap(  'i'  ,  '('  , '()<Esc>i'  ,   { noremap = true, silent = true }  )
vim.api.nvim_set_keymap(  'i'  ,  '['  , '[]<Esc>i'  ,   { noremap = true, silent = true }  )
vim.api.nvim_set_keymap(  'i'  ,  '{'  , '{}<Esc>i'  ,   { noremap = true, silent = true }  )
vim.api.nvim_set_keymap(  'i'  ,  '"'  , '""<Esc>i'  ,   { noremap = true, silent = true }  )
--
local utils = require("utils")
--
if vim.fn.executable("clangd") == 1 then
    vim.lsp.start({
        name = "clangd",
        cmd = { "clangd" },
    })
end
-- 
vim.keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  elseif utils.check_backspace() then 
    return "<Tab>"
  else
    return "<C-x><C-o>"
  end
end, { buffer = true, expr = true, silent = true, noremap = true })

vim.keymap.set("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  else
    return "<C-h>"
  end
end, { buffer = true, expr = true, silent = true, noremap = true })
--
