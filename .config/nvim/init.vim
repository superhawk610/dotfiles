" Plug
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'

Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'

call plug#end()
" ------------------

let mapleader = ' '

noremap <Leader>r :source $MYVIMRC<CR>

" install dependencies
" ---
" vim-plug
" fzf
" rg
"
" nested dependencies
" ---
" coc (:CocInstall X)
" - coc-json
" - coc-tsserver
"
" useful commands
" <C-w> delete previous word (useful for removing leading comment delimiter)
" [number]j / [number]k to move up/down `number` lines
" ------------------

filetype plugin indent on
syntax enable

" vim-airline
let g:airline_theme='soda'
" let g:tmuxline_powerline_separators=0
let g:airline_powerline_fonts=1

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

" hide search highlighting until next search
nnoremap <Leader><Space> :noh<CR>

" shift line up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" allow entering newlines without entering I mode
" (this allows for easily starting a new block with <C-o> o)
nmap <C-o> O<Esc>

" allow exiting I mode with 'ii'
inoremap ii <Esc>

" emulate VS Code bindings for Ctrl+P and Ctrl+F
map <C-p> :History<CR>
nmap <silent> <Leader>p :Files<CR>
nmap <silent> <Leader>f :Rg<CR>

" allow scrolling with arrow keys
nmap <Up> <C-e>
nmap <Down> <C-y>

" allow deleting instead of just cutting
xnoremap <Leader>d "_d

" trigger NerdTree with <C-h>
map <C-h> :NERDTreeToggle<CR>

" file operations
nmap <Leader>s :w<CR>
nmap <Leader>q :q<CR>

" keep non-active buffers in-memory (required by CoC's :TextEdit)
set hidden

" some language servers don't handle backup files well
set nobackup
set nowritebackup

" give more space for displaying messages
" set cmdheight=2

" shorter update times improves UX by reducing delays
set updatetime=300

" don't pass UI text to |ins-completion-menu|
set shortmess+=c

" keep the sign column visible (prevents layout shift when going from 0 - 1+
" signs)
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" use <Tab> to insert completions
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <C-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <CR> to confirm completion (only when selected), otherwise go to next
" line
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<CR>" : "\<C-g>u\<CR>"

" Use <C-m> to comment/uncomment current line (<C-/> would be ideal, but it's
" difficult to map to Ctrl+slash)
nmap <C-m> <Plug>CommentaryLine

" highlight the symbol and all references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" symbol renaming
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " setup formatexpr for specified filetypes
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

command! -nargs=0 Format :call CocAction('format')

" vim-easy-align
" vipga=
" - `v`isually select `i`nner `p`aragraph
" - start EasyAlign command `ga`
" - align around `=`
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" display Coc info in statusline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
