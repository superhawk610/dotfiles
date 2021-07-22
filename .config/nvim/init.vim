" Plug
let in_vscode = exists('g:vscode') " negate to install/update VSCode plugins
let plug_dir = in_vscode ? '~/.vim/plugged-vscode' : '~/.vim/plugged'
call plug#begin(plug_dir)

if !in_vscode
  Plug 'mhinz/vim-startify'
  Plug 'preservim/nerdtree'

  Plug 'ryanoasis/vim-devicons'
  Plug 'kyazdani42/nvim-web-devicons'

  Plug 'lukas-reineke/indent-blankline.nvim'

  " Plug 'vim-airline/vim-airline'
  " Plug 'vim-airline/vim-airline-themes'
  " Plug 'edkolev/tmuxline.vim'
  " Plug 'bling/vim-bufferline'
  Plug 'akinsho/nvim-bufferline.lua'
  Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' }

  Plug 'autoload/onedark.vim' " required for airline theme
  Plug 'joshdick/onedark.vim'
  Plug 'liuchengxu/space-vim-dark'
  Plug 'ap/vim-css-color' " display CSS hex values w/ colored background
  Plug 'ntpeters/vim-better-whitespace' " display trailing whitespace

  Plug 'wfxr/minimap.vim', { 'do': ':!cargo install --locked code-minimap' }
  Plug 'mg979/vim-visual-multi', { 'branch': 'master' }

  Plug 'francoiscabrol/ranger.vim'
  Plug 'rbgrouleff/bclose.vim' " required by ranger.vim

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

  " Emmet
  Plug 'mattn/emmet-vim'
endif

Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'lifepillar/pgsql.vim', { 'for': 'sql' }
Plug 'kevinoid/vim-jsonc' " JSON w/ comments
Plug 'yuezk/vim-js'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
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

let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-toml',
      \ 'coc-elixir',
      \ 'coc-markdownlint',
      \ 'coc-rust-analyzer',
      \ 'coc-prettier',
      \ 'coc-lua',
      \ ]

" --------------------
"
" --- install deps
"
" vim-plug
" fzf (should be installed by :PlugInstall)
" rg
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
" (seems to be broken for now :/)
" if s:onWSL()
"   let g:clipboard = {
"         \    'name': 'win32yank-wsl',
"         \    'cache_enabled': 0,
"         \    'copy': {
"         \      '+': 'win32yank.exe -i --crlf',
"         \      '*': 'win32yank.exe -i --crlf',
"         \    },
"         \    'paste': {
"         \      '+': 'win32yank.exe -o --crlf',
"         \      '*': 'win32yank.exe -o --crlf',
"         \    },
"         \ }
" endif

" allow writing a new nested file with :W
function! WriteCreatingDirs()
  execute ':silent !mkdir -p %:h'
  execute ':write'
endfunction

command W call WriteCreatingDirs()

filetype plugin indent on
syntax enable

      " uncomment to use ANSI Shadow logo
      "
      " \ '          ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗          ',
      " \ '          ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║          ',
      " \ '          ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║          ',
      " \ '          ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║          ',
      " \ '          ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║          ',
      " \ '          ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝          ',

function! s:QuoteOfTheDay()
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
      call add(lines, strcharpart(line, 0, i))
      let line = strcharpart(line, i + 1)
    endwhile

    " append last line
    if strlen(line) > 0
      call add(lines, line)
    endif
  endfor

  return lines
endfunction

" configure splash screen (dragons taken from https://github.com/siduck76/NvChad)
let g:startify_custom_header = [
      \ '                                            ',
      \ '       ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆               ',
      \ '        ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦            ',
      \ '              ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄          ',
      \ '               ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄         ',
      \ '              ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀        ',
      \ '       ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄       ',
      \ '      ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄        ',
      \ '     ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄       ',
      \ '     ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄      ',
      \ '          ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆          ',
      \ '           ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃          ',
      \ '                                            ',
      \ ] + s:QuoteOfTheDay()

let g:startify_lists = [
      \ { 'type': 'bookmarks', 'header': ['  Bookmarks']           },
      \ { 'type': 'files',     'header': ['  Recent Files']        },
      \ { 'type': 'dir',       'header': ['  Files in '. getcwd()] },
      \ ]

let g:startify_bookmarks = [
      \ { 'v': '~/.config/nvim/init.vim' },
      \ { 'z': '~/.zshrc'                },
      \ { 'c': '~/code'                  },
      \ ]

let g:startify_files_number = 5
autocmd FileType startify hi StartifyHeader gui=none guifg=#5C6370 cterm=none ctermfg=242

set termguicolors

" tweak highlight groups
augroup colorextend
  autocmd!
  let s:search_highlight = { 'fg': { 'cterm': 235 }, 'bg': { 'cterm': 221 } }
  autocmd ColorScheme * call onedark#extend_highlight('Search', s:search_highlight)
  autocmd ColorScheme * call onedark#extend_highlight('Function', { 'cterm': 'bold' })
  autocmd ColorScheme * call onedark#extend_highlight('Number', { 'fg': { 'cterm': 4 } })
augroup END

" tweak colors
let g:onedark_color_overrides = {
      \ 'purple': { 'gui': '#7c7cff', 'cterm': 105, 'cterm16': 5 }
      \ }

" highlight current line
set cursorline

" disable vertical split bar
set fillchars+=vert:\ 

" uncomment to enable space-vim theme
" colorscheme space-vim-dark
" hi Normal ctermbg=none
" hi LineNr ctermbg=none
" hi SignColumn ctermbg=none
" uncomment for grey comments
" hi Comment ctermfg=59

let g:onedark_hide_endofbuffer = 1 " hide ~ at end of file
let g:onedark_terminal_italics = 0
colorscheme onedark

" configure airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:bufferline_echo = 0
let g:airline#extensions#bufferline#enabled = 0
let g:airline_theme = 'lucius'

" configure galaxyline
lua <<EOF
local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local buffer = require('galaxyline.provider_buffer')

-- onedark
local colors = {
  bg = '#282c34',
  bg_dim = '#333842',
  bg_light = '#444b59',
  black = '#222222',
  white = '#abb2bf',
  gray = '#868c96',
  red = '#e06c75',
  green = '#98c379',
  yellow = '#e5c07b',
  blue = '#61afef',
  purple = '#7c7cff', -- tweaked to match custom color
  teal = '#56b6c2',
}

function mode_alias(m)
  local alias = {
    n = 'NORMAL',
    i = 'INSERT',
    c = 'COMMAND',
    R = 'REPLACE',
    t = 'TERMINAL',
    [''] = 'V-BLOCK',
    V = 'V-LINE',
    v = 'VISUAL',
  }

  return alias[m] or ''
end

function mode_color(m)
  local mode_colors = {
    normal =  colors.green,
    insert =  colors.blue,
    visual =  colors.purple,
    replace =  colors.red,
  }

  local color = {
    n = mode_colors.normal,
    i = mode_colors.insert,
    c = mode_colors.replace,
    R = mode_colors.replace,
    t = mode_colors.insert,
    [''] = mode_colors.visual,
    V = mode_colors.visual,
    v = mode_colors.visual,
  }

  return color[m] or colors.bg_light
end

-- disable for these file types
gl.short_line_list = { 'startify', 'nerdtree', 'term', 'fugitive' }

gl.section.left[1] = {
  ViModeIcon = {
    separator = '  ',
    separator_highlight = {colors.black, colors.bg_light},
    highlight = {colors.white, colors.black},
    provider = function() return "   " end,
  }
}

gl.section.left[2] = {
  CWD = {
    separator = '  ',
    separator_highlight = function()
      return {colors.bg_light, condition.buffer_not_empty() and colors.bg_dim or colors.bg}
    end,
    highlight = {colors.white, colors.bg_light},
    provider = function()
      local dirname = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      return ' ' .. dirname .. ' '
    end,
  }
}

gl.section.left[3] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {colors.gray, colors.bg_dim},
  }
}

gl.section.left[4] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.gray, colors.bg_dim},
    separator_highlight = {colors.bg_dim, colors.bg},
    separator = '  ',
  }
}

gl.section.left[5] = {
  DiffAdd = {
    icon = '  ',
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    highlight = {colors.white, colors.bg},
  }
}

gl.section.left[6] = {
  DiffModified = {
    icon = '  ',
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    highlight = {colors.gray, colors.bg},
  }
}

gl.section.left[7] = {
  DiffRemove = {
    icon = '  ',
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    highlight = {colors.gray, colors.bg},
  }
}

gl.section.left[8] = {
  CocStatus = {
    highlight = {colors.gray, colors.bg},
    provider = function() return vim.fn['coc#status']() end
  }
}

gl.section.left[9] = {
  CocFunction = {
    icon = 'λ ',
    highlight = {colors.gray, colors.bg},
    provider = function()
      local has_func, func_name = pcall(vim.api.nvim_buf_get_var, 0, 'coc_current_function')
      if not has_func then return '' end
      return func_name or ''
    end,
  }
}

gl.section.right[1] = {
  FileType = {
    highlight = {colors.gray, colors.bg},
    provider = function()
      local buf = require('galaxyline.provider_buffer')
      return string.lower(buf.get_buffer_filetype())
    end,
  }
}

gl.section.right[2] = {
  GitBranch = {
    icon = ' ',
    separator = '  ',
    condition = condition.check_git_workspace,
    highlight = {colors.teal, colors.bg},
    provider = 'GitBranch',
  }
}

gl.section.right[3] = {
  FileLocation = {
    icon = ' ',
    separator = ' ',
    separator_highlight = {colors.bg_dim, colors.bg},
    highlight = {colors.gray, colors.bg_dim},
    provider = function()
      local current_line = vim.fn.line('.')
      local total_lines = vim.fn.line('$')

      if current_line == 1 then
        return 'Top'
      elseif current_line == total_lines then
        return 'Bot'
      end

      local percent, _ = math.modf((current_line / total_lines) * 100)
      return '' .. percent .. '%'
    end,
  }
}

vim.api.nvim_command('hi GalaxyViModeReverse guibg=' .. colors.bg_dim)

gl.section.right[4] = {
  ViMode = {
    icon = ' ',
    separator = ' ',
    separator_highlight = 'GalaxyViModeReverse',
    highlight = {colors.bg, mode_color()},
    provider = function()
      local m = vim.fn.mode() or vim.fn.visualmode()
      local mode = mode_alias(m)
      local color = mode_color(m)
      vim.api.nvim_command('hi GalaxyViMode guibg=' .. color)
      vim.api.nvim_command('hi GalaxyViModeReverse guifg=' .. color)
      return ' ' .. mode .. ' '
    end,
  }
}
EOF

" configure nvim-bufferline
lua <<EOF
require('bufferline').setup{
  options = {
    numbers = 'none',
    separator_style = 'thin',
    always_show_bufferline = true,
    offsets = {{
      filetype = 'nerdtree',
      text = 'NERDTree',
      text_align = 'center',
    }}
  }
}
EOF

" configure tmuxline (only needs to be enabled to save changes,
" once it's good you can just save it with :TmuxlineSnapshot)
let g:tmuxline_preset = 'full'
let g:airline#extensions#tmuxline#enabled = 0

" configure project root
let g:startify_change_to_dir = 0 " disable vim-startify's auto cwd
let g:rooter_targets = '/,*' " everything, including directories
let g:rooter_patterns = ['!^apps', 'mix.exs', '.git']

" configure NERDTree
autocmd VimEnter * NERDTree | wincmd p
let g:NERDTreeQuitOnOpen = 0 " set to 1 to close whenever a file is opened
let g:NERDTreeMouseMode = 3 " single-click for dirs and files
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeMinimalUI = 1
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
let g:webdevicons_conceal_nerdtree_brackets = 1

" close nvim if NERDTree/Minimap are the last buffers/windows open
function! CheckLeftBuffers()
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if getbufvar(winbufnr(i), '&buftype') == 'help' ||
          \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
          \ exists('t:NERDTreeBufName') &&
          \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
          \ bufname(winbufnr(i)) == '-MINIMAP-'
        let i += 1
      else
        break
      endif
    endwhile
    if i == winnr('$') + 1
      qall
    endif
    unlet i
  endif
endfunction
autocmd BufEnter * call CheckLeftBuffers()

" configure ranger
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'
nmap <silent> <Leader>o :Ranger<CR>

" display trailing whitespace
set list
set listchars=tab:»\ ,trail:·,nbsp:⎵,precedes:<,extends:>

" and boundary whitespace
" let g:indent_blankline_char = '·'
" let g:indent_blankline_space_char = '·'
" let g:indent_blankline_space_char_blankline = ' '
" let g:indent_blankline_show_trailing_blankline_indent = v:false
" let g:indent_blankline_show_end_of_line = v:true
let g:indent_blankline_filetype_exclude = ['git', 'help', 'nerdtree', 'startify', 'minimap']
hi IndentBlanklineChar gui=nocombine guifg=#3B4048 cterm=nocombine ctermfg=237 ctermbg=235
hi IndentBlanklineSpaceChar gui=nocombine guifg=#3B4048 cterm=nocombine ctermfg=237 ctermbg=235
" uncomment to enable alternating line background colors
" let g:indent_blankline_char_highlight_list = ['IndentEven', 'IndentOdd']
" let g:indent_blankline_space_char_highlight_list = ['IndentEven', 'IndentOdd']
" hi IndentOdd cterm=nocombine ctermbg=234 ctermfg=236
" hi IndentEven cterm=nocombine ctermbg=236 ctermfg=234

" strip trailing whitespace by default
let g:strip_whitelines_at_eof = 1
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0
let g:show_spaces_that_precede_tabs = 1
let g:better_whitespace_filetypes_blacklist = [
      \   'vim',
      \   'diff',
      \   'gitcommit',
      \   'fugitive',
      \   'unite',
      \   'qf',
      \   'help',
      \   'startify',
      \   'minimap',
      \ ]

":configure vim-commentary
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
  nnoremap <silent> t :NERDTreeToggle<CR>
  nnoremap <silent> T :NERDTreeFind<CR>

  " lazy write/quit
  nmap <Leader>w :w<CR>
  nmap <Leader>q :Bclose<CR>
  nmap <Leader>Q :q<CR>

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
  let g:minimap_block_filetypes = ['git', 'help', 'fugitive', 'nerdtree', 'tagbar', 'startify']
  " autocmd BufReadPost,FileReadPost * if &l:buftype !=# 'help' | :Minimap

  " quickly get to current config
  nmap <silent> <Leader><Leader>v :e ~/.config/nvim/init.vim<CR>

  " easily copy relative path to current file
  nmap <silent> <Leader><Leader>c :let @* = trim(execute('echo @%'))<CR>

  function! FormatFile()
    if &l:filetype ==# 'elixir'
      echo 'Formatting with `mix format`'
      execute ':MixFormat'
    else
      execute 'norm \<Plug>(coc-format)'
    endif
  endfunction

  " format file with prettier using 
  nmap <silent> <Leader>m :call FormatFile()<CR>

  " relies on `bclose.vim`
  function! CloseAllOtherBuffers()
    let me = bufnr('%')
    let bufs = map(filter(copy(getbufinfo()), 'v:val.listed'), 'v:val.bufnr')

    for bufnr in bufs
      if bufnr != me
        execute ':Bclose '. bufnr
      endif
    endfor
  endfunction

  " close all but current buffer
  nmap <silent> <Leader><Leader>q :call CloseAllOtherBuffers()<CR>
endif

" clear search highlighting (<C-/>)
" nnoremap <silent> <C-_> :nohl<CR>:call minimap#vim#ClearColorSearch()<CR>
" inoremap <silent> <C-_> <C-o>:nohl<CR><C-o>:call minimap#vim#ClearColorSearch()<CR>
nnoremap <silent> <C-_> :nohl<CR>
inoremap <silent> <C-_> <C-o>:nohl<CR>

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
