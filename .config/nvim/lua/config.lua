local utils = require('utils')

-- load plugins
require('plugins.filetree')
require('plugins.statusline')

-- configure todo-comments
require('todo-comments').setup {}

-- configure zen-mode
require('zen-mode').setup {}

-- configure nvim-bufferline
require('bufferline').setup {
  options = {
    numbers = 'none',
    separator_style = 'thin',
    always_show_bufferline = true,
    close_command = 'Bclose %d',
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
      },
      {
        filetype = 'DiffviewFiles',
        text = 'Diffview',
        text_align = 'center',
      },
    }
  }
}

-- configure diffview
local dv = require('diffview.config').diffview_callback
local dv_common_binds = {
  ['<tab>'] = dv('select_next_entry'),
  ['<s-tab>'] = dv('select_prev_entry'),
  ['T'] = dv('focus_files'),
  ['t'] = dv('toggle_files')
}
require('diffview').setup {
  diff_binaries = false,
  file_panel = {
    width = 40,
    use_icons = true,
  },
  key_bindings = {
    disable_defaults = true,
    view = dv_common_binds,
    file_panel = utils.merge(dv_common_binds, {
      ['j'] = dv('next_entry'),
      ['<down>'] = dv('next_entry'),
      ['k'] = dv('prev_entry'),
      ['<up>'] = dv('prev_entry'),
      ['<cr>'] = dv('select_entry'),
      ['o'] = dv('select_entry'),
      ['<2-LeftMouse>'] = dv('select_entry'),
      ['-'] = dv('toggle_stage_entry'),
      ['S'] = dv('stage_all'),
      ['U'] = dv('unstage_all'),
      ['X'] = dv('restore_entry'),
      ['R'] = dv('refresh_files'),
    }),
  }
}
