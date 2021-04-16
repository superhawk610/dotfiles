export ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="starship" (set at end of .zshrc)

plugins=(
  wd
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  asdf
)

source $ZSH/oh-my-zsh.sh

# path
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/scripts
export PATH=$PATH:~/Library/Python/3.9/bin

# editor
export EDITOR=nvim

# alias -----------------------

## general
alias c='clear'
alias r='source /etc/zprofile && source ~/.zshrc' # source zprofile first to reset $PATH
alias R='exec zsh'
alias ls='exa'
alias cat='bat'
alias cfg='nvim ~/.zshrc'
alias vcfg='nvim ~/.config/nvim/init.vim'

## elixir
alias iexm='iex -S mix'
alias phx='iex -S mix phx.server'
alias mdg='mix deps.get'

## yarn
alias ya='yarn add'
alias yad='yarn add -D'
alias yai='yarn add --ignore-engines --ignore-optional'
alias yadi='yarn add -D --ignore-engines --ignore-optional'
alias yaid='yarn add -D --ignore-engines --ignore-optional'
alias yr='yarn remove'

## git
alias gc='git checkout'
alias gcb='git checkout -b'
alias gpu='git push'
alias gpl='git pull'
alias gpob='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gr='git rebase'
alias grc='git rebase --continue'
alias grs='git rebase --skip'
alias grh='git reset --hard HEAD'
alias gbd='git branch -D'
alias gcp='git cherry-pick'
alias gs='git status'
alias gl='git log'
alias glp='git log --pretty=oneline --abbrev-commit'
alias gcf='git for-each-ref --format="%(refname:short)" refs/heads | fzf | xargs git checkout'
alias gcfr='git for-each-ref --format="%(refname:short)" refs/remotes | fzf | sed -e s#^origin/## | xargs git checkout'
unalias gp

# python
alias pip='python3 -m pip'
alias pip3='python3 -m pip'
alias venv='[ -d .venv ] && source .venv/bin/activate || echo ".venv not found"'

# docker
alias dc='docker-compose'

# extended initialization -----

if [ -d "$HOME/.zshrc.d" ]
then
  for f in ~/.zshrc.d/*; do
    source $f
  done
fi

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

