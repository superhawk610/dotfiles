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

let mapleader = ' '

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

" emulate VS Code bindings
nmap <silent> <Leader>P :History<CR>
nmap <silent> <Leader>p :Files<CR>
nmap <silent> <Leader>f :Rg<CR>
nmap <silent> <Leader>n :new<CR>

" lazy write/quit
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
