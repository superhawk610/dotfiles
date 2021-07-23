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

if utils#on_wsl " on windows (WSL)
  nnoremap <Leader>o <Cmd>call VSCodeNotify('workbench.action.files.openFile')<CR>
  nnoremap <Leader>O <Cmd>call VSCodeNotify('workbench.action.files.openFolder')<CR>
else         " on MacOS
  nnoremap <Leader>o <Cmd>call VSCodeNotify('workbench.action.files.openFileFolder')<CR>
endif

" calva (clojure)
nnoremap <Leader>cC <Cmd>call VSCodeNotify('calva.jackIn')<CR>
nmap <Leader>cr :w<CR><Cmd>call VSCodeNotify('calva.loadFile')<CR>
