local fzf_win = nil
local fzf_buf = nil

local function toggle_fzf()
  if fzf_win and vim.api.nvim_win_is_valid(fzf_win) then
    vim.api.nvim_win_close(fzf_win, true)
    fzf_win = nil
    fzf_buf = nil
    return
  end

  local exclude_patterns = {}
  local exclude_file_path = vim.fn.expand("~/.config/nvim/search_excludes.txt")
  
  if vim.fn.filereadable(exclude_file_path) == 1 then
    local exclude_lines = vim.fn.readfile(exclude_file_path)
    for _, line in ipairs(exclude_lines) do
      local pattern = string.gsub(line, "%s+", "")
      if pattern ~= "" and not string.match(pattern, "^#") then
        table.insert(exclude_patterns, pattern)
      end
    end
  end

  local fzf_colors = table.concat({
    "--color=bg:#1c1c1c",       
    "bg+:#282828",              
    "hl:#fb4934",               
    "hl+:#fb4934",              
    "prompt:#fe8019",           
    "pointer:#fe8019",          
    "marker:#b8bb26",           
    "spinner:#fabd2f",          
    "info:#83a598",             
  }, ",")

  vim.api.nvim_set_hl(0, "FzfFloatBg", { bg = "#1c1c1c", fg = "#ebdbb2" })
  vim.api.nvim_set_hl(0, "FzfFloatBorder", { bg = "#1c1c1c", fg = "#fe8019" })

  local file_path = vim.fn.expand("~/.config/nvim/search_dirs.txt")
  if vim.fn.filereadable(file_path) == 0 then
    vim.notify("Search dirs file not found: " .. file_path, vim.log.levels.ERROR)
    return
  end

  local dirs = vim.fn.readfile(file_path)
  local valid_dirs = {}
  for _, dir in ipairs(dirs) do
    if dir ~= "" and vim.fn.isdirectory(dir) == 1 then
      table.insert(valid_dirs, vim.fn.shellescape(dir))
    end
  end

  if #valid_dirs == 0 then
    vim.notify("No valid directories found.", vim.log.levels.WARN)
    return
  end

  local search_cmd
  if vim.fn.executable("fd") == 1 then
    local fd_excludes = ""
    for _, pattern in ipairs(exclude_patterns) do
      fd_excludes = fd_excludes .. " --exclude " .. vim.fn.shellescape(pattern)
    end
    search_cmd = "fd --type f --hidden" .. fd_excludes .. " . " .. table.concat(valid_dirs, " ")
  else
    local find_excludes = ""
    for i, pattern in ipairs(exclude_patterns) do
      if i == 1 then
        find_excludes = "-name " .. vim.fn.shellescape(pattern)
      else
        find_excludes = find_excludes .. " -o -name " .. vim.fn.shellescape(pattern)
      end
    end
    
    if #exclude_patterns > 0 then
      search_cmd = "find " .. table.concat(valid_dirs, " ") .. " \\( " .. find_excludes .. " \\) -prune -o -type f -print"
    else
      search_cmd = "find " .. table.concat(valid_dirs, " ") .. " -type f"
    end
  end

  fzf_buf = vim.api.nvim_create_buf(false, true)

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  }

  fzf_win = vim.api.nvim_open_win(fzf_buf, true, opts)
  vim.wo[fzf_win].winhighlight = "Normal:FzfFloatBg,FloatBorder:FzfFloatBorder"

  local temp_file = vim.fn.tempname()
  local full_cmd = string.format("%s | fzf %s > %s", search_cmd, fzf_colors, vim.fn.shellescape(temp_file))

  vim.fn.termopen(full_cmd, {
    on_exit = function()
      if vim.fn.filereadable(temp_file) == 1 then
        local lines = vim.fn.readfile(temp_file)
        local selected = lines[1]
        if selected and selected ~= "" then
          vim.schedule(function()
            vim.cmd("edit " .. vim.fn.fnameescape(selected))
          end)
        end
      end
      vim.fn.delete(temp_file)
      
      if fzf_win and vim.api.nvim_win_is_valid(fzf_win) then
        vim.api.nvim_win_close(fzf_win, true)
      end
      fzf_win = nil
      fzf_buf = nil
    end,
  })

  vim.keymap.set("t", "<C-p>", function()
    if fzf_win and vim.api.nvim_win_is_valid(fzf_win) then
      vim.api.nvim_win_close(fzf_win, true)
      fzf_win = nil
      fzf_buf = nil
    end
  end, { buffer = fzf_buf, silent = true })

  vim.cmd("startinsert")
end

vim.keymap.set("n", "<C-p>", toggle_fzf, { silent = true })
