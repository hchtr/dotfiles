local typst_job_id = nil

local function stop_typst_env()
  if typst_job_id then
    vim.fn.jobstop(typst_job_id)
    typst_job_id = nil
    vim.notify("Typst workspace stopped.", vim.log.levels.INFO)
  end
end

local function start_typst_env()
  if typst_job_id then
    vim.notify("Workspace is already running!", vim.log.levels.WARN)
    return
  end

  local filename = vim.fn.expand("%")
  if filename == "" then return end

  typst_job_id = vim.fn.jobstart({ "bash", "-i", "-c", "typst_watch " .. vim.fn.shellescape(filename) })
  vim.notify("Typst workspace started.", vim.log.levels.INFO)
end

vim.keymap.set("n", "<LocalLeader>r", start_typst_env, { buffer = true, desc = "Start Typst Workspace" })
vim.keymap.set("n", "<LocalLeader>q", stop_typst_env, { buffer = true, desc = "Stop Typst Workspace" })

vim.api.nvim_create_autocmd({ "BufDelete", "VimLeavePre" }, {
  buffer = vim.api.nvim_get_current_buf(),
  callback = stop_typst_env,
})
