local group = vim.api.nvim_create_augroup("user_config", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Flash yanked text
autocmd("TextYankPost", {
  group = group,
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- 'autoread' only works if nvim actually checks; do it on focus / buffer switch
autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = group,
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- LSP keymaps for any language server
autocmd("LspAttach", {
  group = group,
  callback = function(ev)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
    end
    map("K", vim.lsp.buf.hover, "Hover")
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map("gr", vim.lsp.buf.references, "References")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>=", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
  end,
})
