local M = {}

local function check_backspace()
  local col = vim.fn.col('.') - 1
  if col == 0 then return true end
  return vim.fn.getline('.'):sub(col, col):match("%s") ~= nil
end

vim.diagnostic.config({
  virtual_text = true,       
  signs = true,              
  underline = true,          
  update_in_insert = true,
})

function M.setup_buffer_lsp()
  local opts = { buffer = true }

  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then return "<C-n>"
    elseif check_backspace() then return "<Tab>"
    else return "<C-x><C-o>" end
  end, { buffer = true, expr = true, silent = true, noremap = true })

  vim.keymap.set("i", "<S-Tab>", function()
    if vim.fn.pumvisible() == 1 then return "<C-p>"
    else return "<C-h>" end
  end, { buffer = true, expr = true, silent = true, noremap = true })
end

return M

