# shell aliases

## general
alias c='clear'

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

function tz
  node -e 'console.log(`current TZ offset is GMT-${new Date().getTimezoneOffset() / 60}`)'
end

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
alias gsh='git stash'

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
# function gh_repo_input
#   switch count $argv
#     case 2
#       set -f repo $2

#     case 3
#       set -f user $2
#       set -f repo $3
#       set -f repo "$user/$repo"

#     case '*'
#       echo "Usage: $1 [user] [repo]"
#       echo "       $1 [user/repo]"
#       exit 1
#   end

#   echo "git@github.com:$repo"
# end

# function gh_clone
#   local repo
#   repo=$(gh_repo_input "gh_clone" $@)
#   if [[ $? -eq 0 ]]; then
#     git clone $repo
#   else
#     echo $repo # should contain usage text
#   fi
# end

# function gh_add_origin
#   local repo
#   repo=$(gh_repo_input "gh_add_origin" $@)
#   if [[ $? -eq 0 ]]; then
#     git remote add origin $repo
#   else
#     echo $repo # should contain usage text
#   fi
# end

# python
alias pip='python3 -m pip'
alias pip3='python3 -m pip'
alias venv='[ -d .venv ] && source .venv/bin/activate || echo ".venv not found"'
alias py='python3'
alias py2='python'
alias py3='python3'

# docker
alias dc='docker-compose'
alias dps="docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}' | rg --passthru '0.0.0.0:' -r '' | rg --passthru --pcre2 '(\d{4})->\1' -r '\$1'"

# cat CSV files
# function csvcat
#   # the article I found this in recommends passing the -n
#   # flag to `column`, but that isn't supported on macos
#   # ref: https://www.stefaanlippens.net/pretty-csv.html
#   column -t -s, "$@" | less -FSXK
# end

## common misspellings, because we're all human after all :)
alias pob='gpob'
alias ix='mix'
