local g = vim.g
local M = {}

local C = require('utils').colors()
M.update_highlights = C.update_highlights

g.nvim_tree_auto_ignore_ft = {'startify'}

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  vim.keymap.set('n', '<CR>',          api.node.open.edit,               opts('Edit File'))
  vim.keymap.set('n', 'o',             api.node.open.edit,               opts('Edit File'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit,               opts('Edit File'))
  vim.keymap.set('n', '<LeftRelease>', api.node.open.edit,               opts('Toggle Directory'))
  vim.keymap.set('n', 'C',             api.tree.change_root_to_node,     opts('Change Directory'))
  vim.keymap.set('n', '-',             api.tree.change_root_to_parent,   opts('Up'))
  vim.keymap.set('n', 'u',             api.tree.change_root_to_parent,   opts('Up'))
  vim.keymap.set('n', 'X',             api.tree.collapse_all,            opts('Collapse All'))
  vim.keymap.set('n', '<BS>',          api.node.navigate.parent_close,   opts('Close Node'))
  vim.keymap.set('n', 'P',             api.node.navigate.parent,         opts('Parent Node'))
  vim.keymap.set('n', '<',             api.node.navigate.sibling.prev,   opts('Prev Sibling'))
  vim.keymap.set('n', '>',             api.node.navigate.sibling.next,   opts('Next Sibling'))
  vim.keymap.set('n', 'K',             api.node.navigate.sibling.first,  opts('First Sibling'))
  vim.keymap.set('n', 'J',             api.node.navigate.sibling.last,   opts('Last Sibling'))
  vim.keymap.set('n', '<C-x>',         api.node.open.horizontal,         opts('Open Split'))
  vim.keymap.set('n', '<C-v>',         api.node.open.vertical,           opts('Open Vertical Split'))
  vim.keymap.set('n', '<C-t>',         api.node.open.tab,                opts('Open New Tab'))
  vim.keymap.set('n', 'I',             api.tree.toggle_gitignore_filter, opts('Toggle .gitignore'))
  vim.keymap.set('n', 'H',             api.tree.toggle_hidden_filter,    opts('Toggle .dotfiles'))
  vim.keymap.set('n', 'a',             api.fs.create,                    opts('Create New File'))
  vim.keymap.set('n', 'd',             api.fs.remove,                    opts('Delete File'))
  vim.keymap.set('n', 'r',             api.fs.rename,                    opts('Rename File'))
  vim.keymap.set('n', '<C-r>',         api.fs.rename_sub,                opts('Rename File Path'))
  vim.keymap.set('n', 'x',             api.fs.cut,                       opts('Cut'))
  vim.keymap.set('n', 'c',             api.fs.copy.node,                 opts('Copy'))
  vim.keymap.set('n', 'y',             api.fs.copy.filename,             opts('Copy Name'))
  vim.keymap.set('n', 'Y',             api.fs.copy.relative_path,        opts('Copy Relative Path'))
  vim.keymap.set('n', 'p',             api.fs.paste,                     opts('Paste'))
  vim.keymap.set('n', 'R',             api.tree.reload,                  opts('Reload Tree'))
  vim.keymap.set('n', 'q',             api.tree.close,                   opts('Close'))
  vim.keymap.set('n', '?',             api.tree.toggle_help,             opts('Help'))
end

require('nvim-tree').setup {
  on_attach = on_attach,
  disable_netrw = true,
  hijack_netrw = false,
  update_focused_file = { enable = true },
  renderer = {
    group_empty = true,   -- group single-node folders
    add_trailing = false, -- hide trailing `/` on dirs
    highlight_git = true,
    root_folder_modifier = ':~', -- ':t'
    highlight_opened_files = 'none',
    indent_markers = { enable = true },
    icons = {
      show = {
        git = true,
        file = true,
        folder = true,
        folder_arrow = false,
      },
      glyphs = {
        default = '',
        symlink = '',
        git = {
          unstaged = 'U',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '?',
          deleted = 'D',
          ignored = '',
        },
        folder = {
          default = '',
          open = '',
          empty = '',
          empty_open = '',
          symlink = '',
          symlink_open = '',
        },
      },
    },
  },
  git = { ignore = true },
  filters = {
    dotfiles = true,
    custom = {'.git'},
  },
  actions = {
    open_file = {
      quit_on_open = false, -- don't close when opening file
    },
  },
  view = {
    side = 'left',
    width = 40,
  },
}

-- set initial highlights, then call this again as an autocmd
-- on ColorScheme to overwrite nvim-tree's defaults (since
-- it does the same thing)
M.update_highlights()

return M
