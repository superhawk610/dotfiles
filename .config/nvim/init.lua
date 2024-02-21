---------------------------------------
-- install lazy.nvim package manager --
---------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------
-- plugin configuration --
--------------------------

require("lazy").setup({
  -- color schemes
  "joshdick/onedark.vim",
  "ghifarit53/tokyonight-vim",
  "catppuccin/nvim",

  -- utilities & customization
  "mhinz/vim-startify",
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "lukas-reineke/indent-blankline.nvim",
  "lukas-reineke/virt-column.nvim",
  "lukas-reineke/headlines.nvim",
  "fgheng/winbar.nvim",
  { "akinsho/nvim-bufferline.lua", version = "*" },
  { "glepnir/galaxyline.nvim", branch = "main" },
  "folke/todo-comments.nvim",
  "ntpeters/vim-better-whitespace", -- display trailing whitespace
  { "rrethy/vim-hexokinase", build = "make hexokinase" }, -- requires Go
  "rbgrouleff/bclose.vim",
  "tpope/vim-fugitive",
  "airblade/vim-gitgutter",
  "APZelos/blamer.nvim",
  "rhysd/conflict-marker.vim",
  {
    "nvim-telescope/telescope.nvim",
    config = function ()
      require("telescope").setup {
        defaults = {
          layout_strategy = "vertical",
        },
      }
    end
  },
  "airblade/vim-rooter", -- change CWD to project root when opening file
  { "psliwka/vim-smoothie", commit = "10fd0aa57d176718bc2c570f121ab523c4429a25" }, -- smooth scrolling
  "rhysd/clever-f.vim",
  "folke/zen-mode.nvim",
  "godlygeek/tabular", -- improved Markdown support (better syntax highlighting/folding)
  { "preservim/vim-markdown", ft = "markdown" },
  { "iamcco/markdown-preview.nvim", ft = "markdown", build = "cd app && yarn install" },
  { "styled-components/vim-styled-components", branch = "main" },
  "christoomey/vim-tmux-navigator",
  "TamaMcGlinn/quickfixdd", -- remove quickfix lines with `dd`
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "tpope/vim-commentary",
  "justinmk/vim-sneak",
  "machakann/vim-highlightedyank",
  "tommcdo/vim-ninja-feet", -- motions from cursor to start/end of text object
  "easymotion/vim-easymotion",

  -- treesitter & language plugins
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "lua", "vim", "vimdoc", "elixir", "heex", "eex", "javascript", "html" },
        highlight = { enable = true },
      })
    end
  },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup {
        credo = { enable = false },
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = true,
            fetchDeps = false,
            suggestSpecs = true,
          },
          on_attach = function(client, bufnr)
            local opts = { buffer = true, noremap = true, silent = true }

            vim.keymap.set("n", "<leader>efp", ":ElixirFromPipe<cr>", opts)
            vim.keymap.set("n", "<leader>etp", ":ElixirToPipe<cr>", opts)
            vim.keymap.set("v", "<leader>eem", ":ElixirExpandMacro<cr>", opts)

            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            vim.keymap.set("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
            vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
            vim.keymap.set("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
            vim.keymap.set("n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
            vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
            vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
          end,
        },
      }
    end
  },

  -- autocompletion
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  {
    "hrsh7th/nvim-cmp",
    config = function ()
      local cmp = require("cmp")
      local types = require("cmp.types")

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          -- Accept currently selected item. Set `select` to `false`
          -- to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = { i = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }) },
          ["<S-Tab>"] = { i = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }) },
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })
    end
  },
})

---------------------------
-- general configuration --
---------------------------

-- change leader to spacebar
vim.cmd([[let mapleader = " "]])
vim.cmd([[let maplocalleader = "\\"]])

-- enable mouse click & scrolling
vim.cmd([[set mouse=a]])

-- use system clipboard
vim.cmd([[set clipboard+=unnamedplus]])

-- highlight current line
vim.cmd([[set cursorline]])

-- disable vertical split bar
vim.cmd([[set fillchars+=vert:\ ,fold:━]])

-- display trailing whitespace
vim.cmd([[set list]])
vim.cmd([[set listchars=tab:»\ ,trail:·,nbsp:⎵,precedes:<,extends:>]])

-- set how long vim will wait between keypresses and still
--consider it to be a single input/motion
vim.cmd([[set timeoutlen=750]])

vim.cmd([[set number]])     -- display line numbers
vim.cmd([[set hlsearch]])
vim.cmd([[set ignorecase]])
vim.cmd([[set smartcase]])   -- search is only case-sensitive when query contains uppercase
vim.cmd([[set scrolloff=4]]) -- start scrolling when 4 lines away from top/bottom of window

-- use 2 spaces for tabs
vim.cmd([[set expandtab]])     -- use 2 spaces when pressing <Tab>
vim.cmd([[set tabstop=2]])     -- display tab characters as 2 spaces
vim.cmd([[set softtabstop=2]]) -- display soft tabs as 2 spaces
vim.cmd([[set shiftwidth=2]])  -- when indenting with ">", use 2 spaces

-- language-specific tab size
vim.cmd([[autocmd FileType rust setlocal shiftwidth=4 tabstop=4 softtabstop=4]])

-- keep sign column visible (prevents layout shift)
vim.cmd([[set signcolumn=yes]])

-- enable tab completion for filenames
vim.cmd([[set wildmode=longest,list,full]])
vim.cmd([[set wildmenu]])

-- open new splits right/below
vim.cmd([[set splitright]])
vim.cmd([[set splitbelow]])

-- enable syntax highlighting and UI colors
vim.cmd([[filetype plugin indent on]])
vim.cmd([[set termguicolors]])
vim.cmd([[syntax enable]])

-- set colorscheme
vim.cmd([[runtime colorschemes/onedark.vim]])
vim.cmd([[colorscheme catppuccin-frappe]])

-------------
-- keymaps --
-------------

-- ^ and $ are awkward
vim.cmd([[map H ^]])
vim.cmd([[map L $]])

-- make Y behave the same way as C and D
vim.cmd([[nmap Y y$]])

-- remap top/bottom keys
vim.cmd([[noremap gH H]])
vim.cmd([[noremap gL L]])

-- center search results
vim.cmd([[nnoremap <silent> n nzz]])
vim.cmd([[nnoremap <silent> N Nzz]])
vim.cmd([[nnoremap <silent> * *zz]])
vim.cmd([[nnoremap <silent> # #zz]])

-- keep selection while indenting/dedenting
vim.cmd([[vnoremap > >gv]])
vim.cmd([[vnoremap < <gv]])

-- clear search highlighting (<C-/>)
vim.cmd([[nnoremap <silent> <C-_> :nohl<CR>]])
vim.cmd([[inoremap <silent> <C-_> <C-o>:nohl<CR>]])

-- nvim-tree
vim.cmd([[nnoremap <silent> <Leader>t :NvimTreeToggle<CR>]])
vim.cmd([[nnoremap <silent> <Leader>T :NvimTreeFindFile<CR>]])

-- jump between quickfix lines
vim.cmd([[nnoremap <silent> [q :cprevious<CR>]])
vim.cmd([[nnoremap <silent> ]q :cnext<CR>]])
vim.cmd([[nnoremap <silent> <Leader>c :call utils#toggle_quickfix()<CR>]])

-- emulate VS Code bindings
vim.cmd([[nnoremap <silent> <Leader>p :Telescope git_files<CR>]])
vim.cmd([[nnoremap <silent> <Leader>P :Telescope find_files<CR>]])
vim.cmd([[nnoremap <silent> <Leader>f :Telescope live_grep<CR>]])
vim.cmd([[nnoremap <silent> <Leader>F :Telescope grep_string<CR>]])
vim.cmd([[nnoremap <silent> <Leader>n :tabnew<CR>]])

-- lazy write/quit
vim.cmd([[nnoremap <Leader>w :w<CR>]])
vim.cmd([[nnoremap <Leader>W :noa w<CR>]])
vim.cmd([[nnoremap <Leader>q :Bclose<CR>]])
vim.cmd([[nnoremap <silent> <Leader>Q :Startify<CR>:call utils#close_all_other_buffers()<CR>:NvimTreeCollapse<CR>]])
vim.cmd([[nnoremap <silent> <Leader><Leader>q :call utils#close_all_other_buffers()<CR>]])
vim.cmd([[nnoremap <silent> <Leader><Leader>Q :conf qa<CR>]])

-- pane navigation
vim.cmd([[nnoremap <C-h> :TmuxNavigateLeft<CR>]])
vim.cmd([[nnoremap <C-j> :TmuxNavigateDown<CR>]])
vim.cmd([[nnoremap <C-k> :TmuxNavigateUp<CR>]])
vim.cmd([[nnoremap <C-l> :TmuxNavigateRight<CR>]])

-- buffer switching
vim.cmd([[nnoremap <silent> <Leader><Leader>b :BufferLinePick<CR>]])
vim.cmd([[nnoremap <Leader>b :Telescope buffers<CR>]])
vim.cmd([[nnoremap gb :bnext<CR>]])
vim.cmd([[nnoremap gB :bprev<CR>]])

-- markdown preview
vim.cmd([[nmap <C-p> <Plug>MarkdownPreviewToggle]])

-- quickly get to current config
vim.cmd([[nnoremap <silent> <Leader><Leader>v :e ~/.config/nvim/init.lua<CR>]])

-- easily copy relative path to current file
vim.cmd([[nnoremap <silent> <Leader><Leader>c :lua vim.api.nvim_exec("call setreg('*','"..require('utils').current_relative_path().."')",false)<CR>]])
vim.cmd([[nnoremap <silent> <Leader><Leader>C :lua print(require('utils').current_relative_path())<CR>]])

-- activate Zen mode
vim.cmd([[nnoremap <silent> <Leader>z :ZenMode<CR>]])

--------------------------
-- plugin configuration --
--------------------------

vim.cmd([[
  let g:blamer_enabled = 1
  let g:blamer_relative_time = 1
  let g:blamer_template = '<committer>, <committer-time> • <summary>'

  " disable default highlighting, include text after begin/end markers
  let g:conflict_marker_highlight_group = ''
  let g:conflict_marker_begin = '^<<<<<<< .*$'
  let g:conflict_marker_end = '^>>>>>>> .*$'
]])

-- helpful keymaps
--
--   ]x, [x   jump to next/previous conflict
--
--   ct       commit theirs (pending change)
--   co       commit ours   (ignore change)
--   cb       commit both
--   cB       commit both   (reverse order)
--   cn       commit none   (ignore both)

-- configure splash screen (dragons taken from https://github.com/siduck76/NvChad)
vim.cmd([[
  let g:startify_custom_header = [
      \ '                                                    ',
      \ '           ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆                   ',
      \ '            ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦                ',
      \ '                  ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄              ',
      \ '                   ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄             ',
      \ '                  ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀            ',
      \ '           ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄           ',
      \ '          ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄            ',
      \ '         ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄           ',
      \ '         ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄          ',
      \ '              ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆              ',
      \ '               ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃              ',
      \ '                                                    ',
      \ ] + g:utils#quote_of_the_day()
  let g:startify_lists = [
      \ { 'type': 'bookmarks', 'header': ['  Bookmarks']           },
      \ { 'type': 'files',     'header': ['  Recent Files']        },
      \ { 'type': 'dir',       'header': ['  Files in '. getcwd()] },
      \ ]

  let g:startify_bookmarks = [
      \ { 'v': '~/.config/nvim/init.lua' },
      \ { 'z': '~/.zshrc'                },
      \ { 'c': '~/code'                  },
      \ ]

  let g:startify_files_number = 5
]])

-- remove buffer-local mapping to t since it conflicts with NvimTree
vim.cmd([[
  autocmd FileType startify
      \ execute 'nunmap <buffer> t' |
      \ hi StartifyHeader gui=none guifg=#5C6370 cterm=none ctermfg=242
]])

-- configure nvim-tree
vim.cmd([[
  autocmd ColorScheme * lua require('plugins.filetree').update_highlights()
  autocmd VimEnter * if argc() == 0 |
      \ exe "lua require('nvim-tree.api').tree.open()" |
      \ exe "lua require('plugins.filetree').update_highlights()" |
      \ wincmd p |
      \ endif
]])

-- configure fugitive
vim.cmd([[autocmd FileType gitcommit nmap <buffer> <leader>q :wq<CR>]])

-- configure quick exit
vim.cmd([[autocmd FileType git,fugitive,fugitiveblame,vim-plug,help,qf nmap <buffer> <leader>q :q<CR>]])

-- close if NvimTree is the last window open
vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])

-- configure tmuxline (only needs to be enabled to save changes,
-- once it's good you can just save it with :TmuxlineSnapshot)
-- vim.cmd([[
--   let g:tmuxline_preset = 'full'
--   let g:airline#extensions#tmuxline#enabled = 0
-- ]])

-- configure project root
vim.cmd([[
  let g:startify_change_to_dir = 0 " disable vim-startify's auto cwd
  let g:rooter_targets = '/,*' " everything, including directories
  let g:rooter_patterns = ['!^apps', 'mix.exs', '.git']
  let g:rooter_buftypes = ['']
]])

-- configure indentation guides
vim.cmd([[
  let g:indent_blankline_filetype_exclude = ['git', 'help', 'startify', 'NvimTree']
]])

-- disable bclose default bindings
vim.cmd([[let g:bclose_no_plugin_maps = 1]])

-- strip trailing whitespace by default
vim.cmd([[
  let g:strip_whitelines_at_eof = 1
  let g:strip_whitespace_on_save = 1
  let g:strip_whitespace_confirm = 0
  let g:show_spaces_that_precede_tabs = 1
  let g:better_whitespace_filetypes_blacklist = [
      \   'vim',
      \   'diff',
      \   'gitcommit',
      \   'fugitive',
      \   'unite',
      \   'qf',
      \   'help',
      \   'startify',
      \ ]
]])

-- set the max width to 80 for Markdown files
vim.cmd([[
  au Filetype markdown setlocal
      \ textwidth=80
      \ colorcolumn=79
      \ conceallevel=2
]])

-- make code blocks less noticeable
vim.cmd([[
  au Filetype markdown
      \ hi link mkdCodeStart Comment |
      \ hi link mkdCodeEnd Comment
]])

-- enable fenced code block syntax highlighting
vim.cmd([[
  let g:vim_markdown_fenced_languages = [
      \ 'elixir',
      \ 'ts=typescript',
      \ 'typescript',
      \ 'js=javascript',
      \ 'javascript',
      \ 'json',
      \ 'jsonc'
      \ ]
]])

-- disable header folding
vim.cmd([[let g:vim_markdown_folding_disabled = 1]])

-- show start/end tags for code blocks
vim.cmd([[let g:vim_markdown_conceal_code_blocks = 0]])

-- indent markdown lists by 2 spaces
vim.cmd([[let g:vim_markdown_new_list_item_indent = 2]])

-- FIXME: move this config into init.lua`
require("config")
