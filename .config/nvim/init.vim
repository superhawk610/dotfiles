" Plug
let in_vscode = exists('g:vscode') " negate to install/update VSCode plugins
let plug_dir = in_vscode ? '~/.vim/plugged-vscode' : '~/.vim/plugged'
call plug#begin(plug_dir)

if !in_vscode
  Plug 'mhinz/vim-startify'
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'edkolev/tmuxline.vim'

  Plug 'autoload/onedark.vim' " required for airline theme
  Plug 'joshdick/onedark.vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'ap/vim-css-color' " display CSS hex values w/ colored background

  Plug 'wfxr/minimap.vim', { 'do': ':!cargo install --locked code-minimap' }
  Plug 'mg979/vim-visual-multi', { 'branch': 'master' }

  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-rooter' " change CWD to project root when opening file
  Plug 'tpope/vim-vinegar'

  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'vim-test/vim-test'

  Plug 'psliwka/vim-smoothie' " smooth scrolling

  " improved Markdown support (better syntax highlighting/folding)
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
  Plug 'iamcco/markdown-preview.nvim', { 'for': 'markdown', 'do': 'cd app && yarn install' }

  " tmux support
  Plug 'christoomey/vim-tmux-navigator'

  " database interaction
  Plug 'tpope/vim-dadbod', { 'on': 'DB' }
endif

Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'lifepillar/pgsql.vim', { 'for': 'sql' }
Plug 'kevinoid/vim-jsonc' " JSON w/ comments
Plug 'jparise/vim-graphql'

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

" --------------------
"
" --- install deps
"
" vim-plug
" fzf (should be installed by :PlugInstall)
" rg
"
" --- coc languages
"
" coc (:CocInstall X)
" - coc-json
" - coc-tsserver
" - coc-toml
" - coc-elixir
" - coc-markdownlint
" - coc-rust-analyzer
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
"  mode (bound to <C-o> by default, rebound to <C-p> to avoid conflicting
"  with tmux leader); while in insert-normal, the mode prompt should
"  change to `-- (insert) --` to indicate
"
"  additionally, you can press <C-r>= while in insert mode to enter
"  command mode, allowing you to `execute` a command and then return
"  to insert mode
"
" --------------------

function s:onWSL()
  let _ = system("grep -qEi \"(Microsoft|WSL)\" /proc/version")
  return v:shell_error == 0
endfunction

function! GetVersion()
  redir => s
  silent! version
  redir END
  return matchstr(s, 'NVIM v\zs[^\n]*')
endfunction

" change leader to spacebar
let mapleader = ' '

" enable scrolling
set mouse=a

" use system clipboard
set clipboard+=unnamedplus

" enable 2-way clipboard sharing on WSL via `win32yank`
" https://github.com/equalsraf/win32yank
if s:onWSL()
  let g:clipboard = {
        \    'name': 'win32yank-wsl',
        \    'cache_enabled': 0,
        \    'copy': {
        \      '+': 'win32yank.exe -i --crlf',
        \      '*': 'win32yank.exe -i --crlf',
        \    },
        \    'paste': {
        \      '+': 'win32yank.exe -o --crlf',
        \      '*': 'win32yank.exe -o --crlf',
        \    },
        \ }
endif

" allow writing a new nested file with :W
function! WriteCreatingDirs()
  execute ':silent !mkdir -p %:h'
  execute ':write'
endfunction

command W call WriteCreatingDirs()

filetype plugin indent on
syntax enable

" configure splash screen
let g:startify_custom_header = [
      \ '                                                                      ',
      \ '                                                                      ',
      \ '          ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗          ',
      \ '          ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║          ',
      \ '          ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║          ',
      \ '          ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║          ',
      \ '          ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║          ',
      \ '          ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝          ',
      \ '            '. GetVersion(). '                                        ',
      \ '                                                                      ',
      \ ]

let g:startify_lists = [
      \ { 'type': 'bookmarks', 'header': ['  Bookmarks']           },
      \ { 'type': 'dir',       'header': ['  Files in '. getcwd()] },
      \ ]

let g:startify_bookmarks = [
      \ { 'v': '~/.config/nvim/init.vim' },
      \ { 'z': '~/.zshrc'                },
      \ { 'c': '~/code'                  },
      \ ]

" tweak colors
aug colorextend
  autocmd!
  let s:search_highlight = { 'fg': { 'cterm': 235 }, 'bg': { 'cterm': 221 } }
  au ColorScheme * call onedark#extend_highlight('Search', s:search_highlight)
  au ColorScheme * call onedark#extend_highlight('Function', { 'cterm': 'bold' })
aug END

" configure color scheme
set cursorline
let g:onedark_terminal_italics = 1
colorscheme onedark
let g:airline_powerline_fonts = 1
let g:airline_theme = 'onedark'

" enable airline tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" configure tmuxline
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_preset = 'full'
let g:tmuxline_theme = 'jellybeans'

" configure project root
let g:startify_change_to_dir = 0 " disable vim-startify's auto cwd
let g:rooter_targets = '/,*' " everything, including directories
let g:rooter_patterns = ['!^apps', 'mix.exs', '.git']

" configure NERDTree
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMouseMode = 2 " single-click for dirs, double-click for files

" configure vim-commentary
"
" force # as comment prefix for `.ex`/`.exs` files
" (they sometimes incorrectly assume C-style block comments)
autocmd FileType elixir setlocal commentstring=#\ %s

" configure Elixir
let g:mix_format_on_save = 1

" set timeout for which-key & friends
" (also sets how long vim will wait between
" keypresses and still consider it to be
" a single input/motion)
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

" <C-o> is bound to tmux leader, so remap insert-normal keybind
imap <C-p> <C-o>

" ^ and $ are awkward
map H ^
map L $

" remap top/bottom keys
noremap gH H
noremap gL L

" center search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz

" configure Coc
if !in_vscode
  " display Coc info in statusline
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " use <TAB> to trigger completions
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
  endfunction

  " use <C-space> to trigger completion
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  end

  " use `[g` and `]g` to navigate diagnostics (errors & warnings)
  " (`:CocDiagnostics` to list all diagnostics from current buffer)
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " goto definition
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gD <Plug>(coc-type-definition)

  " hover documentation
  nnoremap <silent> gh :call <SID>show_documentation()<CR>

  " code actions
  nmap <silent> <Leader>a <Plug>(coc-codeaction-cursor)

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " scroll doc windows with <C-d>/<C-u> (fast) and <C-y>/<C-e> (slow)
  " (requires manually binding vim-smoothie)
  let g:smoothie_no_default_mappings = 1
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1, 3) : smoothie#downwards()
    nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0, 3) : smoothie#upwards()
    nnoremap <silent><nowait><expr> <C-y> coc#float#has_scroll() ? coc#float#scroll(1, 1) : "\<C-y>"
    nnoremap <silent><nowait><expr> <C-e> coc#float#has_scroll() ? coc#float#scroll(0, 1) : "\<C-e>"
    inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1, 3)\<CR>" : "\<C-d>"
    inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0, 3)\<CR>" : "\<C-u>"
    inoremap <silent><nowait><expr> <C-y> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1, 1)\<CR>" : "\<C-y>"
    inoremap <silent><nowait><expr> <C-e> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0, 1)\<CR>" : "\<C-e>"
  endif
endif

" configure markdown
if !in_vscode
  " use light grey max width marker
  highlight ColorColumn ctermbg=234 " Grey11

  " change the background color for markdown code blocks
  function! s:place_signs()
    " remove all existing signs
    execute "sign unplace * file=".expand("%")

    " iterate through each line in the buffer
    let l:in_block = 0
    for l:lnum in range(1, len(getline(1, "$")))
      " detect the start of a code block
      if !l:in_block && getline(l:lnum) =~ "^```.*$"
        let l:in_block = 1
      endif
      
      " continue placing signs, until the block stops
      if l:in_block
        execute "sign place ".l:lnum." line=".l:lnum." name=codeblock file=".expand("%")
      endif
      
      " stop placing signs
      if l:in_block && getline(l:lnum) =~ "^```$"
        let l:in_block = 0
      endif
    endfor
  endfunction

  function! ColorCodeBlocks() abort
    sign define codeblock linehl=codeBlockBackground

    augroup code_block_background
      autocmd! * <buffer>
      autocmd InsertLeave  <buffer> call s:place_signs()
      autocmd BufEnter     <buffer> call s:place_signs()
      autocmd BufWritePost <buffer> call s:place_signs()
    augroup END
  endfunction

  au FileType markdown
        \ highlight codeBlockBackground ctermbg=234 |
        \ call ColorCodeBlocks()

  " set the max width to 80 for Markdown files
  au Filetype markdown setlocal
        \ textwidth=80
        \ colorcolumn=79
        \ conceallevel=2

  " this is enabled by default for all languages
  " by vim-markdown, leaving it here for reference
  "
  " enable fenced code block syntax highlighting
  " let g:vim_markdown_fenced_languages = [
  "       \ 'elixir',
  "       \ 'ts=typescript', 
  "       \ 'typescript', 
  "       \ 'js=javascript', 
  "       \ 'javascript',
  "       \ 'json',
  "       \ 'jsonc'
  "       \ ]

  " disable header folding
  let g:vim_markdown_folding_disabled = 1
endif

" enable tab completion for filenames
set wildmode=longest,list,full
set wildmenu

" keep selection while indenting/dedenting
vnoremap > >gv
vnoremap < <gv

if in_vscode
  nnoremap <Leader>n <Cmd>call VSCodeNotify('workbench.action.files.newUntitledFile')<CR>
  nnoremap <Leader>m <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
  nnoremap <Leader>N <Cmd>call VSCodeNotify('workbench.action.newWindow')<CR>
  nnoremap <Leader>w <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
  nnoremap <Leader>W <Cmd>call VSCodeNotify('workbench.action.files.saveWithoutFormatting')<CR>
  nnoremap <Leader>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
  nnoremap <Leader>Q <Cmd>call VSCodeNotify('workbench.action.closeAllEditors')<CR>
  nnoremap <Leader>p <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
  nnoremap <Leader>P <Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>
  nnoremap <Leader>F <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
  nnoremap <Leader>ff <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
  nnoremap <Leader>fq <Cmd>call VSCodeNotify('workbench.action.closeFolder')<CR>
  nnoremap <Leader><Leader>q <Cmd>call VSCodeNotify('workbench.action.closeOtherEditors')<CR>
  nnoremap <Leader><Leader>r <Cmd>call VSCodeNotify('workbench.action.closeEditorsToTheRight')<CR>
  nnoremap <Leader><Leader>R <Cmd>call VSCodeNotify('workbench.action.reloadWindow')<CR>
  nnoremap <Leader><Leader>c <Cmd>call VSCodeNotify('copyRelativeFilePath')<CR>
  nnoremap <Leader><Leader><Leader> <Cmd>call VSCodeNotify('workbench.action.openSettingsJson')<CR>

  if s:onWSL() " on windows (WSL)
    nnoremap <Leader>o <Cmd>call VSCodeNotify('workbench.action.files.openFile')<CR>
    nnoremap <Leader>O <Cmd>call VSCodeNotify('workbench.action.files.openFolder')<CR>
  else         " on MacOS
    nnoremap <Leader>o <Cmd>call VSCodeNotify('workbench.action.files.openFileFolder')<CR>
  endif
  
  " calva (clojure)
  nnoremap <Leader>cC <Cmd>call VSCodeNotify('calva.jackIn')<CR>
  nmap <Leader>cr :w<CR><Cmd>call VSCodeNotify('calva.loadFile')<CR>
else
  " emulate VS Code bindings
  nmap <silent> <Leader>P :History<CR>
  nmap <silent> <Leader>p :Files<CR>
  nmap <silent> <Leader>g :CocDiagnostics<CR>
  nmap <silent> <Leader>G :GFiles<CR>
  nmap <silent> <Leader>f :Rg<CR>
  nmap <silent> <Leader>n :tabnew<CR>
  nnoremap <silent> <C-e> :NERDTreeToggle<CR>

  " lazy write/quit
  nmap <Leader>w :w<CR>
  nmap <Leader>q :q<CR>

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
  nnoremap <Leader>B :Buffers<CR>
  nnoremap <Leader>bb :Buffers<CR>
  nnoremap <Leader>bq :bd<CR>
  " close all unsaved buffers
  nnoremap <Leader>bQ :%bd<CR>
  nnoremap gb :bnext<CR>
  nnoremap gB :bprev<CR>

  " save/load views (remember folds)
  nnoremap <Leader>zw :mkview<CR>
  nnoremap <Leader>zo :loadview<CR>

  " markdown preview
  nmap <C-p> <Plug>MarkdownPreviewToggle

  " test runner
  nmap <silent> <Leader>tt :TestNearest<CR>
  nmap <silent> <Leader>tf :TestFile<CR>
  if has('nvim')
    " after running a test, press any key to exit OR press
    " this bind to inspect the output
    tmap <C-i> <C-\><C-n>
  endif

  " minimap
  hi MinimapBase ctermbg=234 ctermfg=145
  hi MinimapHighlight ctermbg=235 ctermfg=111
  hi MinimapSearchHighlight ctermbg=238 ctermfg=252
  
  let g:minimap_auto_start = 0
  let g:minimap_git_colors = 1
  let g:minimap_highlight_range = 1
  let g:minimap_highlight_search = 1
  let g:minimap_base_highlight = 'MinimapBase'
  let g:minimap_highlight = 'MinimapHighlight'
  let g:minimap_search_color = 'MinimapSearchHighlight'
  let g:minimap_block_filetypes = ['fugitive', 'nerdtree', 'tagbar', 'startify']

  nmap <silent> m :MinimapToggle<CR>
  autocmd BufReadPost,FileReadPost * if &l:buftype !=# 'help' | :Minimap
endif

" clear search highlighting (<C-/>)
nnoremap <silent> <C-_> :nohl<CR>:call minimap#vim#ClearColorSearch()<CR>
inoremap <silent> <C-_> <C-o>:nohl<CR><C-o>:call minimap#vim#ClearColorSearch()<CR>

" shift line up/down
"" Windows
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
"" Mac
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

"" reference
"" xterm 256 colors: https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim

