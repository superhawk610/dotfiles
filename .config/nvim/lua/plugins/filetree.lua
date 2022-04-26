local g = vim.g
local M = {}

local C = require('utils').colors()
M.update_highlights = C.update_highlights

g.nvim_tree_auto_ignore_ft = {'startify'}
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_add_trailing = 0  -- hide trailing `/` on dirs
g.nvim_tree_group_empty = 1   -- group single-node folders
g.nvim_tree_root_folder_modifier = ':~' -- ':t'

g.nvim_tree_show_icons = {
  git = 1,
  files = 1,
  folders = 1,
  folder_arrows = 0,
}

g.nvim_tree_icons = {
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
  }
}

local function local_cb(func)
  return string.format(":lua require('plugins.filetree').%s()<CR>", func)
end

function M.toggle_dir()
  local lib = require('nvim-tree.lib')

  local node = lib.get_node_at_cursor()
  if not node then return end
  if not node.nodes then return end

  lib.expand_or_collapse(node)
end

function M.edit_file()
  local lib = require('nvim-tree.lib')
  local open_file = require('nvim-tree.actions.open-file')

  local node = lib.get_node_at_cursor()
  if not node then return end

  if node.link_to and not node.nodes then
    open_file.fn('edit', node.link_to)
  elseif not node.nodes then
    open_file.fn('edit', node.absolute_path)
  end
end

require('nvim-tree').setup {
  open_on_setup = false,
  disable_netrw = true,
  hijack_netrw = false,
  update_focused_file = { enable = true },
  renderer = { indent_markers = { enable = true } },
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
    mappings = {
      custom_only = true,
      list = {
        { key = {'<CR>', 'o'}, action = 'edit' },
        { key = '<2-LeftMouse>', cb = local_cb('edit_file') },
        { key = '<LeftRelease>', cb = local_cb('toggle_dir') },
        { key = 'C', action = 'cd' },
        { key = {'-', 'u'}, action = 'dir_up' },
        { key = 'X', action = 'collapse_all' },
        { key = '<BS>', action = 'close_node' },
        { key = 'P', action = 'parent_node' },
        { key = '<', action = 'prev_sibling' },
        { key = '>', action = 'next_sibling' },
        { key = 'K', action = 'first_sibling' },
        { key = 'J', action = 'last_sibling' },
        { key = '<C-v>', action = 'vsplit' },
        { key = '<C-x>', action = 'split' },
        { key = '<C-t>', action = 'tabnew' },
        { key = 'I', action = 'toggle_ignored' },
        { key = 'H', action = 'toggle_dotfiles' },
        { key = 'a', action = 'create' },
        { key = 'd', action = 'remove' },
        { key = 'r', action = 'rename' },
        { key = '<C-r>', action = 'full_rename' },
        { key = 'x', action = 'cut' },
        { key = 'c', action = 'copy' },
        { key = 'p', action = 'paste' },
        { key = 'r', action = 'rename' },
        { key = 'R', action = 'refresh' },
        { key = 'q', action = 'close' },
        { key = '?', action = 'toggle_help' },
      },
    },
  },
}

-- set initial highlights, then call this again as an autocmd
-- on ColorScheme to overwrite nvim-tree's defaults (since
-- it does the same thing)
M.update_highlights()

return M
