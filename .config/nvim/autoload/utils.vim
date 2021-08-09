function! utils#on_wsl()
  let _ = system("grep -qEi \"(Microsoft|WSL)\" /proc/version")
  return v:shell_error == 0
endfunction

function! utils#get_version()
  redir => s
  silent! version
  redir END
  return matchstr(s, 'NVIM v\zs[^\n]*')
endfunction

function! utils#quote_of_the_day()
  let max_len = 60

  " first, get a quote from Startify
  let quote_lines = startify#fortune#quote()

  " constrain each line to `max_len` or less characters
  let lines = []
  for line in quote_lines
    " if the string is empty, just append a newline and move on
    if strlen(line) == 0
      call add(lines, line)
      continue
    endif

    while strlen(line) > max_len
      " find space at or closest before final character
      let i = max_len
      while i > 0
        if strcharpart(line, i, 1) ==# ' '
          break
        endif
        let i -= 1
      endwhile

      " append lines
      call add(lines, '    '. strcharpart(line, 0, i))
      let line = strcharpart(line, i + 1)
    endwhile

    " append last line
    if strlen(line) > 0
      call add(lines, '    '. line)
    endif
  endfor

  return lines
endfunction

function! utils#check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! utils#show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

function! utils#place_signs()
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

function! utils#color_md_code_blocks()
  sign define codeblock linehl=MarkdownCodeBlock

  augroup code_block_background
    autocmd! * <buffer>
    autocmd InsertLeave  <buffer> call utils#place_signs()
    autocmd BufEnter     <buffer> call utils#place_signs()
    autocmd BufWritePost <buffer> call utils#place_signs()
  augroup END
endfunction

function! utils#format_file()
  if &l:filetype ==# 'elixir'
    echo 'Formatting with `mix format`'
    execute ':MixFormat'
  else
    execute 'norm \<Plug>(coc-format)'
  endif
endfunction

" relies on `bclose.vim`
function! utils#close_all_other_buffers()
  let me = bufnr('%')
  let bufs = map(filter(copy(getbufinfo()), 'v:val.listed'), 'v:val.bufnr')

  for bufnr in bufs
    if bufnr != me
      execute ':Bclose '. bufnr
    endif
  endfor
endfunction

" relies on `bclose.vim`
function! utils#close_all_buffers()
  let bufs = map(filter(copy(getbufinfo()), 'v:val.listed'), 'v:val.bufnr')

  for bufnr in bufs
    execute ':Bclose '. bufnr
  endfor
endfunction

function! utils#toggle_quickfix()
  if getqflist({ 'winid': 0 }).winid
    cclose
  else
    copen
  endif
endfunction

function! utils#identify_highlight()
  echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction
