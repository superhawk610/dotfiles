local M = {}

M.colors = {
  bg = '#1a1b26',
  bg_dim = '#232434',
  bg_light = '#36405d',
  black = '#06080a',
  white = '#abb2bf',
  gray = '#606b97',
  red = '#f7768e',
  green = '#9ece6a',
  yellow = '#e0af68',
  blue = '#7aa2f7',
  purple = '#ad8ee6',
  teal = '#56b6c2',
}

function M.update_highlights()
  local e = vim.api.nvim_exec
  e('hi NvimTreeNormal guibg=' .. M.colors.bg_dim, false)
  e('hi NvimTreeRootFolder guifg=' .. M.colors.gray, false)
  e('hi NvimTreeIndentMarker guifg=' .. M.colors.bg_light, false)
  e('hi NvimTreeFolderIcon guifg=' .. M.colors.white .. ' guibg=' .. M.colors.bg_dim, false)
  e('hi NvimTreeFolderName guifg=' .. M.colors.white .. ' guibg=' .. M.colors.bg_dim, false)
  e('hi NvimTreeOpenedFolderName guifg=' .. M.colors.white .. ' guibg=' .. M.colors.bg_dim, false)
end

return M
