--
local lsp_utils = require("utils.lsp")

if vim.fn.executable("clangd") == 1 then
  vim.lsp.start({
    name = "clangd",
    cmd = { "clangd" },
  })
  lsp_utils.setup_buffer_lsp()
end
--
