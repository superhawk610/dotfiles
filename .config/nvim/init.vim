" Plug
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-commentary'

" nav
Plug 'justinmk/vim-sneak'
if exists('g:vscode')
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

" install deps
" ---
" vim-plug
" fzf
" rg
"
" nested deps
" ---
" coc (:CocInstall X)
" - coc-json
" - coc-tsserver

filetype plugin indent on
syntax enable

" display line numbers
set number relativenumber
highlight clear LineNr
highlight clear SignColumn
highlight LineNr ctermfg=cyan ctermbg=black
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
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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
  system("grep -qEi \"(Microsoft|WSL)\" /proc/version")
  return v:shell_error == 0
endfunction

if exists('g:vscode')
  nnoremap <Leader>n <Cmd>call VSCodeNotify('workbench.action.files.newUntitledFile')<CR>
  nnoremap <Leader>N <Cmd>call VSCodeNotify('workbench.action.newWindow')<CR>
  nnoremap <Leader>w <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
  nnoremap <Leader>W <Cmd>call VSCodeNotify('workbench.action.files.saveWithoutFormatting')<CR>
  nnoremap <Leader>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
  nnoremap <Leader>Q <Cmd>call VSCodeNotify('workbench.action.closeAllEditors')<CR>
  nnoremap <Leader>p <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
  nnoremap <Leader>P <Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>
  nnoremap <Leader>f <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
  nnoremap <Leader><Leader>q <Cmd>call VSCodeNotify('workbench.action.closeOtherEditors')<CR>
  nnoremap <Leader><Leader>r <Cmd>call VSCodeNotify('workbench.action.closeEditorsToTheRight')<CR>
  nnoremap <Leader><Leader>c <Cmd>call VSCodeNotify('copyRelativeFilePath')<CR>
  nnoremap <Leader><Leader><Leader> <Cmd>call VSCodeNotify('workbench.action.openSettingsJson')<CR>

  if s:onWSL() " on windows (WSL)
    nnoremap <Leader>o <Cmd>call VSCodeNotify('workbench.action.files.openFolder')<CR>
  else         " on MacOS
    nnoremap <Leader>o <Cmd>call VSCodeNotify('workbench.action.files.openFileFolder')<CR>
  endif
else
  " emulate VS Code bindings
  nmap <silent> <Leader>P :History<CR>
  nmap <silent> <Leader>p :Files<CR>
  nmap <silent> <Leader>f :Rg<CR>
  nmap <silent> <Leader>n :new<CR>

  " lazy write/quit
  nmap <Leader>w :w<CR>
  nmap <Leader>q :q<CR>
endif

" reload config
noremap <Leader>r :source $MYVIMRC<CR>

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

