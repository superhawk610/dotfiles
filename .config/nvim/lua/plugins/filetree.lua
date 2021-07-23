local tree = require('nvim-tree.config')
local tree_cb = tree.nvim_tree_callback
local g = vim.g

local M = {}

g.nvim_tree_side = 'left'
g.nvim_tree_width = 40
g.nvim_tree_ignore = {'.git'}
g.nvim_tree_gitignore = 1
g.nvim_tree_auto_open = 0
g.nvim_tree_auto_close = 1    -- close if last window open
g.nvim_tree_auto_ignore_ft = {'startify'}
g.nvim_tree_quit_on_open = 0  -- close when opening file
g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_add_trailing = 0  -- hide trailing `/` on dirs
g.nvim_tree_disable_netrw = 1
g.nvim_tree_hijack_netrw = 0
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
    unstaged = '✗',
    staged = '✓',
    unmerged = '',
    renamed = '➜',
    untracked = '★',
    deleted = '',
    ignored = '',
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

function M.close_all()
  local lib = require('nvim-tree.lib')
  local view = require('nvim-tree.view')

  local function iter(entries)
    for _, node in ipairs(entries) do
      if node.entries and node.open then
        iter(node.entries)
        node.open = false
      end
    end
  end

  iter(lib.Tree.entries)
  lib.redraw()

  -- move cursor back to top of tree
  view.set_cursor({2, 0})
end

g.nvim_tree_disable_bindings = 1
g.nvim_tree_bindings = {
  { key = {'<CR>', 'o'}, cb = tree_cb('edit') },
  { key = '<2-LeftMouse>', cb = tree_cb('edit_file') },
  { key = '<LeftRelease>', cb = tree_cb('toggle_dir') },
  { key = 'C', cb = tree_cb('cd') },
  { key = {'-', 'u'}, cb = tree_cb('dir_up') },
  { key = 'X', cb = local_cb('close_all') },
  { key = '<BS>', cb = tree_cb('close_node') },
  { key = 'P', cb = tree_cb('parent_node') },
  { key = '<', cb = tree_cb('prev_sibling') },
  { key = '>', cb = tree_cb('next_sibling') },
  { key = 'K', cb = tree_cb('first_sibling') },
  { key = 'J', cb = tree_cb('last_sibling') },
  { key = '<C-v>', cb = tree_cb('vsplit') },
  { key = '<C-x>', cb = tree_cb('split') },
  { key = '<C-t>', cb = tree_cb('tabnew') },
  { key = 'I', cb = tree_cb('toggle_ignored') },
  { key = 'H', cb = tree_cb('toggle_dotfiles') },
  { key = 'a', cb = tree_cb('create') },
  { key = 'd', cb = tree_cb('remove') },
  { key = 'r', cb = tree_cb('rename') },
  { key = '<C-r>', cb = tree_cb('full_rename') },
  { key = 'x', cb = tree_cb('cut') },
  { key = 'c', cb = tree_cb('copy') },
  { key = 'p', cb = tree_cb('paste') },
  { key = 'r', cb = tree_cb('rename') },
  { key = 'R', cb = tree_cb('refresh') },
  { key = 'q', cb = tree_cb('close') },
  { key = '?', cb = tree_cb('toggle_help') },
}

return M
