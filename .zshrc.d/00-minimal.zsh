# minimal ZSH environment (safe to run on a clean install)

# path
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/scripts

# editor
export EDITOR=nvim

# alias -----------------------

## general
alias c='clear'
alias r='source /etc/zprofile && source ~/.zshrc' # source zprofile first to reset $PATH
alias R='exec zsh'
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

# python
alias pip='python3 -m pip'
alias pip3='python3 -m pip'
alias venv='[ -d .venv ] && source .venv/bin/activate || echo ".venv not found"'

# docker
alias dc='docker-compose'

