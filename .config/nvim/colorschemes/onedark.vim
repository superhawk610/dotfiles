" set global variable so Lua knows which scheme is active
let g:colorscheme = 'onedark'

" tweak colors
let g:onedark_color_overrides = {
      \ 'purple': { 'gui': '#7c7cff', 'cterm': 105, 'cterm16': 5 }
      \ }

let g:onedark_hide_endofbuffer = 1 " hide ~ at end of file
let g:onedark_terminal_italics = 0

colorscheme onedark

hi IndentBlanklineChar gui=nocombine guifg=#3B4048 cterm=nocombine ctermfg=237 ctermbg=235
hi IndentBlanklineSpaceChar gui=nocombine guifg=#3B4048 cterm=nocombine ctermfg=237 ctermbg=235

hi DiffAdd guifg=none guibg=#39443b
hi DiffDelete guifg=#49323a guibg=#49323a

hi ConflictMarkerBegin guibg=#29351d guifg=#9ece6a
hi ConflictMarkerOurs guibg=#29351d
hi ConflictMarkerTheirs guibg=#2b3a58
hi ConflictMarkerEnd guibg=#2b3a58 guifg=#7aa2f7
hi ConflictMarkerCommonAncestorHunk guibg=#5e4a2e

" FIXME:
" TODO:
" NOTE:
" WARN:
hi TodoBgFIX guifg=#282c34 guibg=#e06c75
hi TodoFgFIX guifg=#e06c75
hi TodoSignFIX guifg=#e06c75
hi TodoBgTODO guifg=#282c34 guibg=#61afef
hi TodoFgTODO guifg=#61afef
hi TodoSignTODO guifg=#61afef

hi CocHintSign NONE
hi link CocHintSign Comment

hi link javaIdentifier NONE

" hi mkdCode guifg=#abb2bf guibg=#444b59
" hi mkdCodeDelimiter guifg=#abb2bf guibg=#444b59
