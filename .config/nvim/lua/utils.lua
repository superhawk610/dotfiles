local M = {}

function M.colorscheme()
  return 'onedark'
end

function M.merge(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end

  return t1
end

function M.colors()
  return require('colors.' .. M.colorscheme())
end

local function strip_prefix(str, prefix)
  return (str:sub(0, #prefix) == prefix) and str:sub(#prefix+1) or str
end

function M.current_relative_path()
  local full_path = vim.fn.expand('%:p')
  local working_dir = vim.fn.getcwd() .. '/'
  return strip_prefix(full_path, working_dir)
end

return M
