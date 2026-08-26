local utils = require("utils")
--
vim.api.nvim_set_keymap(  'i'  ,  '('  , '()<Esc>i'  ,   { noremap = true, silent = true }  )
vim.api.nvim_set_keymap(  'i'  ,  '['  , '[]<Esc>i'  ,   { noremap = true, silent = true }  )
vim.api.nvim_set_keymap(  'i'  ,  '{'  , '{}<Esc>i'  ,   { noremap = true, silent = true }  )
vim.api.nvim_set_keymap(  'i'  ,  '"'  , '""<Esc>i'  ,   { noremap = true, silent = true }  )
--
vim.api.nvim_set_keymap(  't'  ,  '<ESC>'  ,  '<C-\\><C-n>'  ,  {noremap = true}  )
--
vim.keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  elseif utils.check_backspace() then
    return "<Tab>"
  else
    return "<C-x><C-o>"
  end
end, { expr = true, silent = true, noremap = true })

vim.keymap.set("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  else
    return "<C-h>"
  end
end, { expr = true, silent = true, noremap = true })
--
