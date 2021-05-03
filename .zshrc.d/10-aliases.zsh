# shell aliases

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
alias gaa='git add -A'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gpu='git push'
alias gpl='git pull'
alias gpob='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gr='git rebase'
alias grc='git rebase --continue'
alias grs='git rebase --skip'
alias grh='git reset --hard HEAD'
alias gb='git branch'
alias gbd='git branch -D'
alias gbmv='git branch -m $(git branch --show-current)'
alias gcp='git cherry-pick'
alias gs='git status'
alias gl='git log'
alias glp='git log --pretty=oneline --abbrev-commit'
alias gcf='git for-each-ref --format="%(refname:short)" refs/heads | fzf | xargs git checkout'
alias gcfr='git for-each-ref --format="%(refname:short)" refs/remotes | fzf | sed -e s#^origin/## | xargs git checkout'

gh_clone() {
  case "$#" in
    1)
      local repo=$1
      ;;

    2)
      local user=$1
      local repo=$2
      local repo="$user/$repo"
      ;;

    *)
      echo "Usage: gh_clone [user] [repo]"
      echo "       gh_clone [user/repo]"
      return 1
      ;;
  esac
  git clone "git@github.com:$repo"
}

# python
alias pip='python3 -m pip'
alias pip3='python3 -m pip'
alias venv='[ -d .venv ] && source .venv/bin/activate || echo ".venv not found"'

# docker
alias dc='docker-compose'

