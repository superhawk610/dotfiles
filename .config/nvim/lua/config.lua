local utils = require('utils')
local C = utils.colors()

-- configure devicons
require('nvim-web-devicons').setup {
  override = {
    heex = {
      icon = '',
      color = '#a074c4',
      name = 'Heex',
    },
    zig = {
      icon = '',
      color = '#f69a1b',
      name = 'Zig',
    },
  },
}

require('virt-column').setup()

-- load plugins
require('plugins.filetree')
require('plugins.statusline')

-- configure todo-comments
require('todo-comments').setup {}

-- configure zen-mode
require('zen-mode').setup {
  window = {
    backdrop = 0.9,
  },
}

-- configure nvim-bufferline
require('bufferline').setup {
  highlights = {
    indicator_selected = {
      guifg = C.colors.blue,
    },
  },
  options = {
    numbers = 'none',
    separator_style = 'thin',
    always_show_bufferline = true,
    close_command = 'Bclose %d',
    show_close_icon = false,
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'NvimTree',
        text_align = 'center',
      },
      -- {
      --   filetype = 'nerdtree',
      --   text = 'NERDTree',
      --   text_align = 'center',
      -- },
      -- {
      --   filetype = 'DiffviewFiles',
      --   text = 'Diffview',
      --   text_align = 'center',
      -- },
    }
  }
}

-- configure diffview (https://github.com/sindrets/diffview.nvim)
-- local dv = require('diffview.config').diffview_callback
-- local dv_common_binds = {
--   ['<tab>'] = dv('select_next_entry'),
--   ['<s-tab>'] = dv('select_prev_entry'),
--   ['T'] = dv('focus_files'),
--   ['t'] = dv('toggle_files')
-- }
-- require('diffview').setup {
--   diff_binaries = false,
--   use_icons = true,
--   file_panel = { width = 40 },
--   key_bindings = {
--     disable_defaults = true,
--     view = dv_common_binds,
--     file_panel = utils.merge(dv_common_binds, {
--       ['j'] = dv('next_entry'),
--       ['<down>'] = dv('next_entry'),
--       ['k'] = dv('prev_entry'),
--       ['<up>'] = dv('prev_entry'),
--       ['<cr>'] = dv('select_entry'),
--       ['o'] = dv('select_entry'),
--       ['<2-LeftMouse>'] = dv('select_entry'),
--       ['-'] = dv('toggle_stage_entry'),
--       ['S'] = dv('stage_all'),
--       ['U'] = dv('unstage_all'),
--       ['X'] = dv('restore_entry'),
--       ['R'] = dv('refresh_files'),
--     }),
--   }
-- }

-- configure headlines
require('headlines').setup {
  markdown = {
    headline_highlights = { 'Headline1', 'Headline2', 'Headline3' }
  },
}

-- configure telescope
require ('telescope').setup {
  extensions = {
    dash = {
      dash_app_path = '/Applications/Dash.app',
      debounce = 750,
      file_type_keywords = {
        elixir = { 'elixir' },
      },
    },
  },
}

-- configure mini.nvim
-- disable drawing, just use for indent text objects `ii` and `ai`
require('mini.indentscope').setup {}
vim.g.miniindentscope_disable = true
