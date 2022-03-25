local tree_cb = require('nvim-tree.config').nvim_tree_callback
local g = vim.g

local M = {}

g.nvim_tree_auto_ignore_ft = {'startify'}
g.nvim_tree_quit_on_open = 0  -- close when opening file
g.nvim_tree_indent_markers = 1
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
    unstaged = '✗',
    staged = '✓',
    unmerged = '',
    renamed = '➜',
    untracked = 'U',
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
  if not node.entries then return end

  lib.expand_or_collapse(node)
end

function M.edit_file()
  local lib = require('nvim-tree.lib')

  local node = lib.get_node_at_cursor()
  if not node then return end

  if node.link_to and not node.entries then
    lib.open_file('edit', node.link_to)
  elseif not node.entries then
    lib.open_file('edit', node.absolute_path)
  end
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

require('nvim-tree').setup {
  open_on_setup = false,
  disable_netrw = true,
  hijack_netrw = false,
  auto_close = true, -- close if last window open
  auto_open = false,
  follow = true,
  git = { ignore = true },
  filters = {
    dotfiles = true,
    custom = {'.git'},
  },
  view = {
    side = 'left',
    width = 40,
    mappings = {
      custom_only = true,
      list = {
        { key = {'<CR>', 'o'}, cb = tree_cb('edit') },
        { key = '<2-LeftMouse>', cb = local_cb('edit_file') },
        { key = '<LeftRelease>', cb = local_cb('toggle_dir') },
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
      },
    },
  },
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

-- set initial highlights, then call this again as an autocmd
-- on ColorScheme to overwrite nvim-tree's defaults (since
-- it does the same thing)
M.update_highlights()

return M
