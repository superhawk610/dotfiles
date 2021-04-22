" Plug
let in_vscode = exists('g:vscode') " switch to 1 to install/update
let plug_dir = in_vscode ? '~/.vim/plugged-vscode' : '~/.vim/plugged'
call plug#begin(plug_dir)

if !in_vscode
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }

  Plug 'psliwka/vim-smoothie'

  " improved Markdown support (better syntax highlighting/folding)
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
endif

Plug 'cespare/vim-toml'
Plug 'elixir-editors/vim-elixir'
Plug 'kana/vim-textobj-user'
Plug 'amiralies/vim-textobj-elixir'
Plug 'kevinoid/vim-jsonc' " JSON w/ comments

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
" --- nested deps
"
" coc (:CocInstall X)
" - coc-json
" - coc-tsserver
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
" --------------------

filetype plugin indent on
syntax enable

" display line numbers
set number
highlight clear LineNr
highlight clear SignColumn
highlight LineNr ctermfg=242 ctermbg=black
highlight CursorLineNr ctermfg=yellow ctermbg=233

" use 2 spaces for tabs
set expandtab     " use 2 spaces when pressing <Tab>
set tabstop=2     " display tab characters as 2 spaces
set softtabstop=2 " display soft tabs as 2 spaces
set shiftwidth=2  " when indenting with '>', use 2 spaces

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

" display Coc info in statusline
if !in_vscode
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
endif

if !in_vscode
  " use light grey max width marker
  highlight ColorColumn ctermbg=234 " Grey11

  " set the max width to 80 for Markdown files
  au Filetype markdown setlocal
        \ textwidth=80
        \ colorcolumn=79
        \ conceallevel=2

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
endif

" enable tab completion for filenames
set wildmode=longest,list,full
set wildmenu

" keep selection while indenting/dedenting
vnoremap > >gv
vnoremap < <gv

" change leader to spacebar
let mapleader = ' '

" vscode.neovim
function s:onWSL()
  let _ = system("grep -qEi \"(Microsoft|WSL)\" /proc/version")
  return v:shell_error == 0
endfunction

if in_vscode
  nnoremap <Leader>n <Cmd>call VSCodeNotify('workbench.action.files.newUntitledFile')<CR>
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
  nmap <silent> <Leader>f :Rg<CR>
  nmap <silent> <Leader>n :new<CR>

  " lazy write/quit
  nmap <Leader>w :w<CR>
  nmap <Leader>q :q<CR>

  " reload config
  noremap <Leader>r :source $MYVIMRC<CR>

  " tab switching
  nnoremap <C-t> :tabnew<CR>
  nnoremap <C-h> :tabprevious<CR>
  nnoremap <C-j> :tabprevious<CR>
  nnoremap <C-k> :tabnext<CR>
  nnoremap <C-l> :tabnext<CR>
endif

" clear search highlighting
nnoremap <C-n> :nohl<CR>

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

