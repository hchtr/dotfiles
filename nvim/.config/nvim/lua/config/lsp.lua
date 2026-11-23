-- To add a language: define vim.lsp.config("<name>", {...}) and vim.lsp.enable("<name>").

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
end
vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("clangd", {
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp" },
  root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" },
})

if vim.fn.executable("clangd") == 1 then
  vim.lsp.enable("clangd")
end
