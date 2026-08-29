vim.api.nvim_set_keymap(  'i'  ,  '('  , '()<Esc>i'  ,   { noremap = true, silent = true }  )
vim.api.nvim_set_keymap(  'i'  ,  '['  , '[]<Esc>i'  ,   { noremap = true, silent = true }  )
vim.api.nvim_set_keymap(  'i'  ,  '{'  , '{}<Esc>i'  ,   { noremap = true, silent = true }  )
vim.api.nvim_set_keymap(  'i'  ,  '"'  , '""<Esc>i'  ,   { noremap = true, silent = true }  )
--
local lsp_utils = require("utils.lsp")

if vim.fn.executable("clangd") == 1 then
  vim.lsp.start({
    name = "clangd",
    cmd = { "clangd" },
    root_dir = lsp_utils.get_root_dir({ ".git", "CMakeLists.txt" }),
  })
  lsp_utils.setup_buffer_lsp()
end
--
