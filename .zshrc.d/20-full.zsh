# path
export PATH=$PATH:~/Library/Python/3.9/bin
export PATH=$PATH:~/.cargo/bin

if on_mac; then
  export PATH=$PATH:$(brew --prefix)/bin
  export PATH=/usr/local/opt/llvm@11/bin:$PATH
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
alias dotp='dot -Tsvg -Gpad=0.2 -Gbgcolor="#282c34" -Ncolorscheme=rdpu9 -Ecolorscheme=rdpu9 -Ncolor=1 -Nfontcolor=1 -Ecolor=1'

# setup -----------------------

# deno
export DENO_INSTALL="/home/aaron/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# clojure
# export LEIN_USE_BOOTCLASSPATH=no # fix for ultra

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

# starship (prompt)
eval "$(starship init zsh)"
