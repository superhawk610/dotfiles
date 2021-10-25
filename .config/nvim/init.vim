" Plug
let in_vscode = exists('g:vscode') " negate to install/update VSCode plugins
let plug_dir = in_vscode ? '~/.vim/plugged-vscode' : '~/.vim/plugged'
call plug#begin(plug_dir)

if !in_vscode
  Plug 'nvim-lua/plenary.nvim' " Lua utils for a bunch of stuff
  Plug 'mattn/webapi-vim' " read from files/web APIs

  Plug 'mhinz/vim-startify'

  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'

  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'lukas-reineke/headlines.nvim'
  Plug 'TaDaa/vimade' " dim inactive splits

  " Plug 'vim-airline/vim-airline'
  " Plug 'vim-airline/vim-airline-themes'
  " Plug 'edkolev/tmuxline.vim'

  Plug 'akinsho/nvim-bufferline.lua'
  Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' }

  Plug 'joshdick/onedark.vim'
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " requires Go
  Plug 'folke/todo-comments.nvim'
  Plug 'ntpeters/vim-better-whitespace' " display trailing whitespace

  Plug 'wfxr/minimap.vim', { 'do': ':!cargo install --locked code-minimap' }
  Plug 'mg979/vim-visual-multi', { 'branch': 'master' }

  Plug 'francoiscabrol/ranger.vim'
  Plug 'rbgrouleff/bclose.vim' " required by ranger.vim

  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'APZelos/blamer.nvim'
  Plug 'sindrets/diffview.nvim'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'nvim-telescope/telescope.nvim'
  if has('macunix') | Plug 'mrjones2014/dash.nvim' | endif

  Plug 'airblade/vim-rooter' " change CWD to project root when opening file
  Plug 'tpope/vim-vinegar'

  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'vim-test/vim-test'
  Plug 'puremourning/vimspector'

  Plug 'psliwka/vim-smoothie' " smooth scrolling

  Plug 'folke/zen-mode.nvim'

  Plug 'scr1pt0r/crease.vim' " fold text customization

  " improved Markdown support (better syntax highlighting/folding)
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
  Plug 'iamcco/markdown-preview.nvim', { 'for': 'markdown', 'do': 'cd app && yarn install' }

  " styled-components syntax
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

  " tmux support
  Plug 'christoomey/vim-tmux-navigator'

  " database interaction
  Plug 'tpope/vim-dadbod', { 'on': 'DB' }

  " Emmet
  Plug 'mattn/emmet-vim'

  " remove quickfix lines with `dd`
  Plug 'TamaMcGlinn/quickfixdd'
endif

Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'lifepillar/pgsql.vim', { 'for': 'sql' }
Plug 'kevinoid/vim-jsonc' " JSON w/ comments
Plug 'yuezk/vim-js'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'jparise/vim-graphql'
Plug 'hail2u/vim-css3-syntax'
Plug 'vim-crystal/vim-crystal'
Plug 'bfrg/vim-cpp-modern'
Plug 'ziglang/zig.vim'
Plug 'vim-python/python-syntax'

" Elixir
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
Plug 'kana/vim-textobj-user'
Plug 'amiralies/vim-textobj-elixir', { 'for': 'elixir' }
Plug 'mhinz/vim-mix-format', { 'for': 'elixir' }

Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'machakann/vim-highlightedyank'
Plug 'tommcdo/vim-ninja-feet' " motions from cursor to start/end
                              " of text object

if in_vscode
  Plug 'asvetliakov/vim-easymotion' " use VSCode text decoration instead of editing buffer
else
  Plug 'easymotion/vim-easymotion'  " use the standard plugin when running `nvim`
endif

" sexp
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

call plug#end()

" when `coc-eslint` is run for the first time, it requires permission;
" to grant it, run `CocCommand eslint.showOutputChannel` and confirm
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-toml',
      \ 'coc-elixir',
      \ 'coc-markdownlint',
      \ 'coc-rust-analyzer',
      \ 'coc-prettier',
      \ 'coc-lua',
      \ 'coc-jedi',
      \ 'coc-diagnostic',
      \ ]

" --------------------
"
" --- install deps
"
" vim-plug
" fzf (should be installed by :PlugInstall)
" rg
"
" --- usage
"
" VSCode's neovim integration requires a tweaked version
" of vim-easymotion, which is incompatible with the standard
" version used by terminal nvim. To support this, vim-plug
" maintains two distinct plugin directories, one for VSCode
" and another for terminal nvim. When installing for the
" first time, run the full setup (:PlugInstall and :CocInstall)
" and then manually switch `plug_dir` and install again.
"
" --- tips & tricks
"
"  # Beautify JSON using an external tool (jq)
"
"  this command will pass the current line to `jq` and overwrite
"  the current line with the output (formatting the JSON as a result)
"
"      :.!jq .
"
"  you can accomplish the same thing with the entire file by using
"
"      :%!jq .
"
"  # format XML file with `xmllint`
"
"      :%!xmllint --format -
"
"  # run a single command without triggering autocmds
"
"  disable autocmds during execution of a command by prefixing with :noa
"
"      " write a file without formatting
"      :noa w
"
" --- fzf
"
"  # Opening search results in a new tab/split
"
"  while hovering over a search result from fzf (:Files), you can use
"  the following key combos to open it in a new tab or split
"
"      <C-t> new tab
"      <C-x> horizontal split (:sp)
"      <C-v> vertical split (:vsp)
"
" --- lesser-known modes
"
"  # insert-normal and command modes
"
"  while in insert mode, you can enter insert-command mode to run a
"  single normal mode command and then move directly back to insert
"  mode (bound to <C-o>); while in insert-normal, the mode prompt
"  should change to `-- (insert) --` to indicate
"
"  additionally, you can press `<C-r> =` while in insert mode to enter
"  command mode, allowing you to `execute` a command and then return
"  to insert mode
"
" --- folds and folding
"
"  by default, folds are disabled for most file types
"
"  to enable folding, set `foldmethod` to one of the following values
"
"      manual (default)
"      indent
"      syntax (you probably want this one)
"
"      expr / marker / diff (these are less used)
"
"  once folding is enabled, use these commands to toggle
"
"      zo   Open fold
"      zc   Close fold
"      za   Toggle fold
"
"      zO   Open all folds (under cursor)
"      zC   Close all folds
"      zA   Toggle all folds
"
"      zr   Peel back one layer of folding (in entire buffer)
"      zR   Open all folds in buffer
"
"      zm   Fold by one more layer (in entire buffer)
"      zM   Close all folds
"
" --------------------

" change leader to spacebar
let mapleader = ' '

" enable mouse click & scrolling
set mouse=a

" use system clipboard
set clipboard+=unnamedplus

" highlight current line
set cursorline

" disable vertical split bar
set fillchars+=vert:\ ,fold:━

" display trailing whitespace
set list
set listchars=tab:»\ ,trail:·,nbsp:⎵,precedes:<,extends:>

" set how long vim will wait between keypresses and still
" consider it to be a single input/motion
set timeoutlen=750

set number      " display line numbers
set hlsearch
set ignorecase
set smartcase   " search is only case-sensitive when query contains uppercase
set scrolloff=4 " start scrolling when 4 lines away from top/bottom of window

" use 2 spaces for tabs
set expandtab     " use 2 spaces when pressing <Tab>
set tabstop=2     " display tab characters as 2 spaces
set softtabstop=2 " display soft tabs as 2 spaces
set shiftwidth=2  " when indenting with '>', use 2 spaces

" language-specific tab size
autocmd FileType rust setlocal shiftwidth=4 tabstop=4 softtabstop=4

" keep non-active buffers in-memory (required by CoC's :TextEdit)
set hidden

" avoid backup files since they don't play nice with some language servers
set nobackup
set nowritebackup

" shorter update times improves UX by reducing delays
set updatetime=300

" don't pass UI text to |ins-completion-menu|
set shortmess+=c

" keep sign column visible (prevents layout shift)
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" enable tab completion for filenames
set wildmode=longest,list,full
set wildmenu

augroup filetypedetect
  autocmd BufRead,BufNewFile .env.local setfiletype sh
  autocmd BufRead,BufNewFile .envrc setfiletype sh
  autocmd BufRead,BufNewFile *.porth setfiletype porth
augroup END

filetype plugin indent on
set termguicolors
syntax enable

let g:coc_status_error_sign = ' '
let g:coc_status_warning_sign = ' '

let g:blamer_enabled = 1
let g:blamer_relative_time = 1
let g:blamer_template = '<committer>, <committer-time> • <summary>'

" tweak colors
let g:onedark_color_overrides = {
      \ 'purple': { 'gui': '#7c7cff', 'cterm': 105, 'cterm16': 5 }
      \ }

let g:onedark_hide_endofbuffer = 1 " hide ~ at end of file
let g:onedark_terminal_italics = 0
if !in_vscode | colorscheme onedark | endif

hi IndentBlanklineChar gui=nocombine guifg=#3B4048 cterm=nocombine ctermfg=237 ctermbg=235
hi IndentBlanklineSpaceChar gui=nocombine guifg=#3B4048 cterm=nocombine ctermfg=237 ctermbg=235

hi DiffAdd guifg=none guibg=#39443b
hi DiffDelete guifg=#49323a guibg=#49323a

" hi mkdCode guifg=#abb2bf guibg=#444b59
" hi mkdCodeDelimiter guifg=#abb2bf guibg=#444b59

" ^ and $ are awkward
map H ^
map L $

" make Y behave the same way as C and D
nmap Y y$

" remap top/bottom keys
noremap gH H
noremap gL L

" center search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz

" keep selection while indenting/dedenting
vnoremap > >gv
vnoremap < <gv

" shift indents while inserting with <M-[> and <M-]>
imap “ <C-d>
imap ‘ <C-t>
imap <M-[> <C-d>
imap <M-]> <C-t>

nnoremap <silent> t :NvimTreeToggle<CR>
nnoremap <silent> T :NvimTreeFindFile<CR>

nmap <silent> <Leader>o :Ranger<CR>

" jump between quickfix lines
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> <Leader>c :call utils#toggle_quickfix()<CR>

" switch between .c and .h
nnoremap <silent> [h :e %:r.h<CR>
nnoremap <silent> ]h :e %:r.c<CR>

" use `[g` and `]g` to navigate diagnostics (errors & warnings)
" (`:CocDiagnostics` to list all diagnostics from current buffer)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" goto definition
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)

" visual multi
let g:VM_maps = {}
let g:VM_maps['Undo'] = 'u'
let g:VM_maps['Redo'] = '<C-r>'
" let g:VM_maps['Add Cursor Up'] = '<C-Up>'
let g:VM_maps['Add Cursor Down'] = '<C-m>'

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'

nnoremap <silent> <Leader>v :CocList outline<CR>

" hover documentation
nnoremap <silent> gh :call utils#show_documentation()<CR>

" code actions
nmap <silent> <Leader>a <Plug>(coc-codeaction-cursor)

" use <C-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" scroll doc windows with <C-d>/<C-u> (fast) and <C-y>/<C-e> (slow)
" (requires manually binding vim-smoothie)
let g:smoothie_no_default_mappings = 1

" enable all Python syntax highlighting features
let g:python_highlight_all = 1

" custom fold text
let g:crease_foldtext = { 'default': '━━┓ %t%{CreaseChanged()} ┏%=┥ %l lines  ┝━━' }

function! CreaseChanged()
  return gitgutter#fold#is_changed() ? ' *' : ''
endfunction

nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1, 3) : smoothie#downwards()
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0, 3) : smoothie#upwards()
nnoremap <silent><nowait><expr> <C-y> coc#float#has_scroll() ? coc#float#scroll(1, 1) : "\<C-y>"
nnoremap <silent><nowait><expr> <C-e> coc#float#has_scroll() ? coc#float#scroll(0, 1) : "\<C-e>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1, 3)\<CR>" : "\<C-d>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0, 3)\<CR>" : "\<C-u>"
inoremap <silent><nowait><expr> <C-y> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1, 1)\<CR>" : "\<C-y>"
inoremap <silent><nowait><expr> <C-e> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0, 1)\<CR>" : "\<C-e>"

" use <TAB> to cycle completions
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ utils#check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" autocomplete on <CR>
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" exclude file names from :Rg results
command! -bang -nargs=* Rg call fzf#vim#grep(
      \ "rg --column --line-number --no-heading --color=always --smart-case ". shellescape(<q-args>), 1,
      \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

command! -bang -nargs=* RgExact call fzf#vim#grep(
      \ "rg --column --line-number --no-heading --color=always --fixed-strings ". shellescape(<q-args>), 1,
      \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" emulate VS Code bindings
nnoremap <silent> <Leader>P :History<CR>
nnoremap <silent> <Leader>p :Files<CR>
nnoremap <silent> <Leader>g :CocDiagnostics<CR>
nnoremap <silent> <Leader>G :GFiles<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>F :Rg <C-r><C-w><CR>
nnoremap <silent> <Leader>n :tabnew<CR>
" nnoremap <silent> t :NERDTreeToggle<CR>
" nnoremap <silent> T :NERDTreeFind<CR>

" lazy write/quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :Bclose<CR>
nnoremap <silent> <Leader>Q :Startify<CR>:call utils#close_all_other_buffers()<CR>
nnoremap <silent> <Leader><Leader>q :call utils#close_all_other_buffers()<CR>

" reload config
noremap <Leader>r :source $MYVIMRC<CR>

" tab switching
nnoremap <C-t> :tabnew<CR>

" pane navigation
nnoremap <C-h> :TmuxNavigateLeft<CR>
nnoremap <C-j> :TmuxNavigateDown<CR>
nnoremap <C-k> :TmuxNavigateUp<CR>
nnoremap <C-l> :TmuxNavigateRight<CR>

" buffer switching
nnoremap <silent> <Leader><Leader>b :BufferLinePick<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap gb :bnext<CR>
nnoremap gB :bprev<CR>

" save/load views (remember folds)
nnoremap <Leader>zw :mkview<CR>
nnoremap <Leader>zo :loadview<CR>

" markdown preview
nmap <C-p> <Plug>MarkdownPreviewToggle

" test runner
nnoremap <silent> <Leader>tt :TestNearest<CR>
nnoremap <silent> <Leader>tf :TestFile<CR>
if has('nvim')
  " after running a test, press any key to exit OR press
  " this bind to inspect the output
  tmap <C-i> <C-\><C-n>
endif

" quickly get to current config
nnoremap <silent> <Leader><Leader>v :e ~/.config/nvim/init.vim<CR>

" easily copy relative path to current file
nnoremap <silent> <Leader><Leader>c :let @* = trim(execute('echo @%'))<CR>
nnoremap <silent> <Leader><Leader>C :echo trim(execute('echo @%'))<CR>

" format file with prettier using
nnoremap <silent> <Leader>m :call utils#format_file()<CR>

" activate Zen mode
nnoremap <silent> <Leader>z :ZenMode<CR>

" open/close visual git diff
nnoremap <Leader>xd :DiffviewOpen<CR>
nnoremap <Leader>xD :DiffviewClose<CR>

" clear search highlighting (<C-/>)
" nnoremap <silent> <C-_> :nohl<CR>:call minimap#vim#ClearColorSearch()<CR>
" inoremap <silent> <C-_> <C-o>:nohl<CR><C-o>:call minimap#vim#ClearColorSearch()<CR>
nnoremap <silent> <C-_> :nohl<CR>
inoremap <silent> <C-_> <C-o>:nohl<CR>

" align asm comments at end of line
command! TabAsm GTabularize /^\s*\S.*\zs;/l4c1
augroup Asm
  autocmd FileType asm nnoremap <silent><buffer> <Leader>m :TabAsm<CR>
  autocmd FileType asm
        \ autocmd! Asm BufWritePre <buffer> execute "TabAsm"
augroup END

" configure splash screen (dragons taken from https://github.com/siduck76/NvChad)
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
      \ { 'v': '~/.config/nvim/init.vim' },
      \ { 'z': '~/.zshrc'                },
      \ { 'c': '~/code'                  },
      \ ]

let g:startify_files_number = 5

" remove buffer-local mapping to t since it conflicts with NvimTree
autocmd FileType startify
      \ execute 'nunmap <buffer> t' |
      \ hi StartifyHeader gui=none guifg=#5C6370 cterm=none ctermfg=242

" configure nvim-tree
autocmd ColorScheme * lua require('plugins.filetree').update_highlights()
autocmd VimEnter * if argc() == 0 && !in_vscode |
      \ exe "lua require('nvim-tree').open()" |
      \ exe "lua require('plugins.filetree').update_highlights()" |
      \ wincmd p |
      \ endif

" configure vimade
let g:vimade = { "fadelevel": 0.6 }
autocmd BufEnter * if &ft ==# 'NvimTree' | execute 'VimadeBufDisable' | endif

" configure fugitive
autocmd FileType fugitive
      \ nmap <buffer> <leader>q :q<CR><C-w><C-w>
autocmd FileType gitcommit
      \ nmap <buffer> <leader>q :wq<CR>

" configure tmuxline (only needs to be enabled to save changes,
" once it's good you can just save it with :TmuxlineSnapshot)
let g:tmuxline_preset = 'full'
let g:airline#extensions#tmuxline#enabled = 0

" configure project root
let g:startify_change_to_dir = 0 " disable vim-startify's auto cwd
let g:rooter_targets = '/,*' " everything, including directories
let g:rooter_patterns = ['!^apps', 'mix.exs', '.git']

" configure ranger
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'

" configure indentation guides
let g:indent_blankline_filetype_exclude = ['git', 'help', 'nerdtree', 'startify', 'minimap', 'NvimTree']

" disable bclose default bindings
let g:bclose_no_plugin_maps = 1

" strip trailing whitespace by default
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
      \   'minimap',
      \ ]

" force # as comment prefix for `.ex`/`.exs` files
" (they sometimes incorrectly assume C-style block comments)
autocmd FileType elixir setlocal commentstring=#\ %s
autocmd FileType c,cpp setlocal commentstring=//\ %s

" configure Elixir
let g:mix_format_on_save = 1

" configure C/C++
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1

" change the background color for markdown code blocks
" au FileType markdown
"       \ highlight MarkdownCodeBlock guibg=#1a1c21 ctermbg=234 |
"       \ call utils#color_md_code_blocks()

" set the max width to 80 for Markdown files
au Filetype markdown setlocal
      \ textwidth=80
      \ colorcolumn=79
      \ conceallevel=2

" make code blocks less noticeable
au Filetype markdown
      \ hi link mkdCodeStart Comment |
      \ hi link mkdCodeEnd Comment

" enable fenced code block syntax highlighting
let g:vim_markdown_fenced_languages = [
      \ 'elixir',
      \ 'ts=typescript',
      \ 'typescript',
      \ 'js=javascript',
      \ 'javascript',
      \ 'json',
      \ 'jsonc'
      \ ]

" disable header folding
let g:vim_markdown_folding_disabled = 1

" show start/end tags for code blocks
let g:vim_markdown_conceal_code_blocks = 0

" indent markdown lists by 2 spaces
let g:vim_markdown_new_list_item_indent = 2

" custom emmet snippets
" https://docs.emmet.io/customization/snippets/
let s:emmet_snippets_file = '~/.config/nvim/emmet-snippets.json'
if !in_vscode
  let g:user_emmet_settings = webapi#json#decode(join(readfile(expand(s:emmet_snippets_file)), ''))
endif

if in_vscode
  " enable VSCode bindings
  runtime 'vscode.vim'
else
  " load lua config
  execute "lua require('config')"
end
