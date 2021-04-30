# copy to ~/.zshrc.d to enable


# path
export PATH=$PATH:~/Library/Python/3.9/bin

# alias -----------------------

## general
alias ls='exa'
alias cat='bat'

## ultralist
alias ul='ultralist l'
alias ule='ultralist edit'
alias ula='ultralist add'
alias ulab='ultralist add +backlog'

## git
unalias gp # set by oh-my-zsh

# setup -----------------------

# clojure
# export LEIN_USE_BOOTCLASSPATH=no # fix for ultra

# java
export PATH="~/.jenv/bin:$PATH"
eval "$(jenv init -)"

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
eval "$(direnv hook zsh)"

# starship (prompt)
eval "$(starship init zsh)"

