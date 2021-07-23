" configure airline
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 0
" let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:bufferline_echo = 0
" let g:airline#extensions#bufferline#enabled = 0
" let g:airline_theme = 'lucius'

" configure NERDTree
" autocmd VimEnter * NERDTree | wincmd p
" let g:NERDTreeQuitOnOpen = 0 " set to 1 to close whenever a file is opened
" let g:NERDTreeMouseMode = 2 " single-click for dirs, double-click for files
" let g:NERDTreeHijackNetrw = 0
" let g:NERDTreeMinimalUI = 1
" let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
" let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
" let g:NERDTreeDirArrowExpandable = "\u00a0"
" let g:NERDTreeDirArrowCollapsible = "\u00a0"
" let g:webdevicons_conceal_nerdtree_brackets = 1

" close nvim if NERDTree/Minimap are the last buffers/windows open
" function! CheckLeftBuffers()
"   if tabpagenr('$') == 1
"     let i = 1
"     while i <= winnr('$')
"       if getbufvar(winbufnr(i), '&buftype') == 'help' ||
"           \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
"           \ exists('t:NERDTreeBufName') &&
"           \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
"           \ bufname(winbufnr(i)) == '-MINIMAP-'
"         let i += 1
"       else
"         break
"       endif
"     endwhile
"     if i == winnr('$') + 1
"       qall
"     endif
"     unlet i
"   endif
" endfunction
" autocmd BufEnter * call CheckLeftBuffers()

" minimap
hi MinimapBase ctermbg=234 ctermfg=242
hi MinimapHighlight ctermbg=235 ctermfg=4
hi MinimapSearchHighlight ctermbg=238 ctermfg=252

let g:minimap_auto_start = 0
let g:minimap_git_colors = 1
let g:minimap_highlight_range = 1
let g:minimap_highlight_search = 1
let g:minimap_base_highlight = 'MinimapBase'
let g:minimap_highlight = 'MinimapHighlight'
let g:minimap_search_color = 'MinimapSearchHighlight'
let g:minimap_block_filetypes = ['git', 'help', 'fugitive', 'nerdtree', 'tagbar', 'startify', 'NvimTree']
" autocmd BufReadPost,FileReadPost * if &l:buftype !=# 'help' | :Minimap
