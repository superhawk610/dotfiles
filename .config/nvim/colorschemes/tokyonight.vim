" set global variable so Lua knows which scheme is active
let g:colorscheme = 'tokyonight'

let g:tokyonight_style = 'night' " night / storm
let g:tokyonight_enable_italic = 0
let g:tokyonight_menu_selection_background = 'green' " green / red / blue
let g:tokyonight_current_word = 'grey background' " bold / underline / italic / grey background

if !in_vscode | colorscheme tokyonight | endif

hi IndentBlanklineChar gui=nocombine guifg=#3B4048 cterm=nocombine ctermfg=237 ctermbg=235
hi IndentBlanklineSpaceChar gui=nocombine guifg=#3B4048 cterm=nocombine ctermfg=237 ctermbg=235

hi GitGutterAdd guifg=#9ece6a guibg=#1a1b26
hi GitGutterDelete guifg=#f7768e guibg=#1a1b26
hi GitGutterChange guifg=#7aa2f7 guibg=#1a1b26
hi GitGutterChangeDelete guifg=#e0af68 guibg=#1a1b26

hi diffAdded guibg=#29351d guifg=#9ece6a
hi diffRemoved guibg=#351a1f guifg=#f7768e

hi SignColumn guifg=#a9b1d6 guibg=#1a1b26
hi NvimTreeEndOfBuffer guifg=#232434 guibg=#232434

hi HighlightedyankRegion guifg=#1a1b26 guibg=#7aa2f7

hi ConflictMarkerBegin guibg=#29351d guifg=#9ece6a
hi ConflictMarkerOurs guibg=#29351d
hi ConflictMarkerTheirs guibg=#2b3a58
hi ConflictMarkerEnd guibg=#2b3a58 guifg=#7aa2f7
hi ConflictMarkerCommonAncestorHunk guibg=#5e4a2e

" lukas-reineke/headlines.nvim
hi Headline1 guibg=#29351d guifg=#9ece6a
hi Headline2 guibg=#2b3a58 guifg=#7aa2f7
hi Headline3 guibg=#5e4a2e guifg=#e0af68
hi CodeBlock guibg=#232434

" FIXME:
" TODO:
" NOTE:
" WARN:
hi Todo NONE
hi TodoBgFIX guifg=#1a1b26 guibg=#f7768e
hi TodoFgFIX guifg=#f7768e
hi TodoSignFIX guifg=#f7768e
hi TodoBgTODO guifg=#1a1b26 guibg=#9ece6a
hi TodoFgTODO guifg=#9ece6a
hi TodoSignTODO guifg=#9ece6a
hi TodoBgNOTE guifg=#1a1b26 guibg=#abb2bf
hi TodoFgNOTE guifg=#abb2bf
hi TodoSignNOTE guifg=#abb2bf
hi TodoBgWARN guifg=#1a1b26 guibg=#e0af68
hi TodoFgWARN guifg=#e0af68
hi TodoSignWARN guifg=#e0af68

hi CocHintSign NONE
hi link CocHintSign Comment

hi link javaIdentifier NONE
