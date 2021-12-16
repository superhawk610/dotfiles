# shell aliases

## general
alias c='clear'
alias r='source /etc/zprofile && source ~/.zshrc' # source zprofile first to reset $PATH
alias R='exec zsh'
alias cfg='nvim ~/.zshrc'
alias vcfg='nvim ~/.config/nvim/init.vim'

## tmux
alias tm='tmux'
alias tma='tmux attach'
alias tmn='tmux new -s'
alias tmls='tmux list-sessions'

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

## npm
# get a list of all failing test suites
alias npm-test-failing-suites='CI=true npm test 2>&1 | rg FAIL'

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
alias gdiff='git diff --no-index'

### Ignore files (outside of .gitignore)
alias gil='git update-index --skip-worktree'
alias gul='git update-index --no-skip-worktree'

### Checkout branches
alias gcf='git for-each-ref --format="%(refname:short)" refs/heads | fzf | xargs git checkout'
alias gcfr='git for-each-ref --format="%(refname:short)" refs/remotes | fzf | sed -e s#^origin/## | xargs git checkout'

# get a git URL for the specified repo
#
# $1: command name
# $2: username or username/repo
# $3: repo or blank
gh_repo_input() {
  local user repo
  case "$#" in
    2)
      repo=$2
      ;;

    3)
      user=$2
      repo=$3
      repo="$user/$repo"
      ;;

    *)
      echo "Usage: $1 [user] [repo]"
      echo "       $1 [user/repo]"
      exit 1
      ;;
  esac
  echo "git@github.com:$repo"
}

gh_clone() {
  local repo
  repo=$(gh_repo_input "gh_clone" $@)
  if [[ $? -eq 0 ]]; then
    git clone $repo
  else
    echo $repo # should contain usage text
  fi
}

gh_add_origin() {
  local repo
  repo=$(gh_repo_input "gh_add_origin" $@)
  if [[ $? -eq 0 ]]; then
    git remote add origin $repo
  else
    echo $repo # should contain usage text
  fi
}

# python
alias pip='python3 -m pip'
alias pip3='python3 -m pip'
alias venv='[ -d .venv ] && source .venv/bin/activate || echo ".venv not found"'

# docker
alias dc='docker-compose'

# cat CSV files
csvcat() {
  column -t -s, -n "$@" | less -FSXK
}
