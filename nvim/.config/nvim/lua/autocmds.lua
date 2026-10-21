-- 
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if os.getenv("HCHTR_HOME") then
            vim.cmd("cd " .. os.getenv("HCHTR_HOME"))
        end
    end,
})
--
