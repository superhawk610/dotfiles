local M = {}

M.colors = {
  bg = '#282c34',
  bg_dim = '#333842',
  bg_light = '#444b59',
  black = '#222222',
  white = '#abb2bf',
  gray = '#868c96',
  red = '#e06c75',
  green = '#98c379',
  yellow = '#e5c07b',
  blue = '#61afef',
  purple = '#7c7cff', -- tweaked to match custom color
  teal = '#56b6c2',
}

function M.update_highlights()
  vim.api.nvim_exec([[
    " hi NvimTreeNormal guibg=#222222
    " hi NvimTreeCursorLine guibg=#7c7cff guifg=#222222
    hi NvimTreeNormal guibg=#2d313b
    hi NvimTreeRootFolder guifg=#778399
    hi NvimTreeIndentMarker guifg=#444b59
    hi NvimTreeFolderIcon guifg=#abb2bf guibg=#2d313b
    hi NvimTreeFolderName guifg=#abb2bf guibg=#2d313b
    hi NvimTreeOpenedFolderName guifg=#abb2bf guibg=#2d313b
  ]], false)
end

return M
