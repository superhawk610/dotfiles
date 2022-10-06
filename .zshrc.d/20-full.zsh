# path
export PATH=$PATH:~/Library/Python/3.9/bin
export PATH=$PATH:~/.cargo/bin

if on_mac; then
  export PATH="$PATH:$(brew --prefix)/bin"
  export PATH="$(brew --prefix llvm@11)/bin:$PATH"
  # use brew's copy of git so we don't have to rely on XCode tools
  # (at least until I get off cabin WiFi and can download them lol)
  export PATH="$(brew --prefix git)/bin:$PATH"
fi

if on_wsl; then
  # forward GTK windows to windows X server
  export LIBGL_ALWAYS_INDIRECT=1
  export DISPLAY=$(ip route  | awk '/default via / {print $3; exit}' 2>/dev/null):0

  [[ "$PWD" = "/mnt/c/Users/Aaron Ross" ]] && cd ~
fi

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

## git
unalias gp # set by oh-my-zsh

## graphviz
alias dotp='dot -Tsvg -Gpad=0.2 -Gbgcolor="#282c34" -Nfontname="FiraCode Nerd Font" -Ncolorscheme=rdpu9 -Ecolorscheme=rdpu9 -Ncolor=1 -Nfontcolor=1 -Ecolor=1'

# setup -----------------------

# bat
export BAT_THEME=OneHalfDark

# deno
export DENO_INSTALL="/home/aaron/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# clojure
export LEIN_USE_BOOTCLASSPATH=no # fix for ultra

# java
if on_mac; then
  export PATH="~/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

# ruby
# export PATH=$PATH:~/.gem/ruby/2.6.0/bin

# p10k
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nvm (disabled in favor of asdf)
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# direnv
if on_mac; then
  eval "$(direnv hook zsh)"
fi

# elixir
export ERL_AFLAGS="-kernel shell_history enabled"

# ocaml
[ -x "$(command -v opam)" ] && eval $(opam env)

# lua
[ -x "$(command -v luarocks)" ] && eval $(luarocks path)

# go
export PATH=$PATH:/usr/local/go/bin

# starship (prompt)
eval "$(starship init zsh)"

# print something fun!
im_feeling_lucky
