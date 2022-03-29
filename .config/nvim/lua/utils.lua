local M = {}

function M.merge(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end

  return t1
end

function M.colors()
  return require('colors.' .. vim.g.colorscheme)
end

return M
