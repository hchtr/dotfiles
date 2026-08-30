local lsp_utils = require("utils.lsp")

if vim.fn.executable("tinymist") == 1 then
  vim.lsp.start({
    name = "tinymist",
    cmd = { "tinymist" }, 
    settings = { exportPdf = "onType", semanticTokens = "enable", formatterMode = "typstyle" },
  })
  lsp_utils.setup_buffer_lsp()
end

vim.keymap.set("n", "<leader>pv", function()
  local pdf_path = vim.fn.expand("%:p:r") .. ".pdf"
  vim.fn.jobstart({ "sioyek", pdf_path }, { detach = true })
end, { buffer = true })

