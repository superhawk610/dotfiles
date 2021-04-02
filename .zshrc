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

# alias

## general
alias c='clear'
alias r='source ~/.zshrc'
alias ls='exa'
alias cat='bat'
alias cfg='nvim ~/.zshrc'
alias vcfg='nvim ~/.config/nvim/init.vim'

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

# docker
alias dc='docker-compose'

# path
export PATH=$PATH:~/.local/bin
# export PATH=$PATH:~/Library/Python/3.8/bin

# editor
export EDITOR=nvim

# clojure
# export LEIN_USE_BOOTCLASSPATH=no # fix for ultra

# java
export PATH="~/.jenv/bin:$PATH"
eval "$(jenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# python
alias venv='[ -d .venv ] && source .venv/bin/activate || echo ".venv not found"'

# ruby
# export PATH=$PATH:~/.gem/ruby/2.6.0/bin

# starship (prompt)
eval "$(starship init zsh)"

