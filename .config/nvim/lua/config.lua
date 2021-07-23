-- load plugins
require('plugins.filetree')
require('plugins.statusline')

-- configure zen-mode
require('zen-mode').setup {}

-- configure nvim-bufferline
require('bufferline').setup{
  options = {
    numbers = 'none',
    separator_style = 'thin',
    always_show_bufferline = true,
    offsets = {
      -- {
      --   filetype = 'nerdtree',
      --   text = 'NERDTree',
      --   text_align = 'center',
      -- },
      {
        filetype = 'NvimTree',
        text = 'NvimTree',
        text_align = 'center',
      }
    }
  }
}
