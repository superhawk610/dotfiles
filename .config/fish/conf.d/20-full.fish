# path
fish_add_path ~/Library/Python/3.9/bin
fish_add_path ~/.cargo/bin

if on_mac
  fish_add_path "$(brew --prefix)/bin"
  fish_add_path "$(brew --prefix llvm@11)/bin"

  # use brew's copy of git so we don't have to rely on XCode tools
  # (at least until I get off cabin WiFi and can download them lol)
  fish_add_path "$(brew --prefix git)/bin"
end

if on_wsl
  # forward GTK windows to windows X server
  export LIBGL_ALWAYS_INDIRECT=1
  export DISPLAY=$(ip route  | awk '/default via / {print $3; exit}' 2>/dev/null):0

  [ "$PWD" = "/mnt/c/Users/Aaron Ross" ] && cd ~
end

# alias -----------------------

## general
alias ls='exa'
alias cat='bat'

## ultralist
alias ul='ultralist'
alias ull='ultralist list'
alias ule='ultralist edit'
alias ula='ultralist add'
alias ulc='ultralist complete'
alias ulab='ultralist add +backlog'
alias ulgc='ultralist archive c && ultralist archive gc'

## graphviz
alias dotp='dot -Tsvg -Gpad=0.2 -Gbgcolor="#282c34" -Nfontname="FiraCode Nerd Font" -Ncolorscheme=rdpu9 -Ecolorscheme=rdpu9 -Ncolor=1 -Nfontcolor=1 -Ecolor=1'

# setup -----------------------

if status is-interactive && not set -q fish_one_time_setup
  set -g fish_one_time_setup

  # fisher (fish plugin manager)
  if not type -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher install jorgebucaran/fisher
    fisher install PatrickF1/fzf.fish
    fisher install fischerling/plugin-wd
    fisher install h-matsuo/fish-color-scheme-switcher
  end

  # fish
  scheme set tokyonight

  # bat
  export BAT_THEME=OneHalfDark

  # direnv
  if on_mac
    direnv hook fish | source
  end

  # elixir
  export ERL_AFLAGS="-kernel shell_history enabled"

  # go
  fish_add_path /usr/local/go/bin

  # starship (prompt)
  starship init fish | source

  # asdf package manager
  [ -d ~/.asdf ] && source ~/.asdf/asdf.fish
end
