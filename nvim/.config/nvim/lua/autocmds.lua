-- 
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if os.getenv("HCHTR_HOME") then
            vim.cmd("cd " .. os.getenv("HCHTR_HOME"))
        end
    end,
})
--
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("Vex")
  end,
})
--
vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
    pattern = { "*.c", "*.h" },
    callback = function()
        if vim.fn.executable("clangd") == 1 then
            vim.lsp.buf_attach_client(0, vim.lsp.start_client({
                name = "clangd",
                cmd = { "clangd" },
                filetypes = { "c" },
            }))
            vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
        end
    end,
})
--
local fold_group = vim.api.nvim_create_augroup("AutoPersistenceFolds", { clear = true })

vim.opt.viewoptions = { "folds", "cursor" }

vim.api.nvim_create_autocmd("BufWinLeave", {
  group = fold_group,
  pattern = "*.*", 
  callback = function()
    vim.cmd("silent! mkview")
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = fold_group,
  pattern = "*.*",
  callback = function()
    vim.cmd("silent! loadview")
  end,
})

--
