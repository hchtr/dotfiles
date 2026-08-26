local U = {}

function U.check_backspace()
  local col = vim.fn.col('.') - 1
  if col == 0 then
    return true
  end
  return vim.fn.getline('.'):sub(col, col):match("%s") ~= nil
end

return U
