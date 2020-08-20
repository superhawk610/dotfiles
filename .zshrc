# --- zsh config --- #

# configure oh-my-zsh
export ZSH="/Users/aaronross/.oh-my-zsh"

# set theme
ZSH_THEME="spaceship"

# configure some extra goodies

## WIP prompt
### defaults
SPACESHIP_WIP_PREFIX="${SPACESHIP_WIP_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_WIP_SUFFIX="${SPACESHIP_WIP_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_WIP_SYMBOL="${SPACESHIP_WIP_SYMBOL="🚧 "}"
SPACESHIP_WIP_TEXT="${SPACESHIP_WIP_TEXT="WIP!!! "}"
SPACESHIP_WIP_COLOR="${SPACESHIP_WIP_COLOR="red"}"

## overrides
SPACESHIP_WIP_PREFIX=""
SPACESHIP_WIP_SUFFIX=""
SPACESHIP_WIP_TEXT="WIP "

spaceship_wip() {
  [[ $SPACESHIP_WIP_SHOW == false ]] && return

  spaceship::is_git || return
  spaceship::exists work_in_progress || return

  if [[ $(work_in_progress) == "WIP!!" ]]; then
    # Display WIP section
    spaceship::section \
      "$SPACESHIP_WIP_COLOR" \
      "$SPACESHIP_WIP_PREFIX" \
      "$SPACESHIP_WIP_SYMBOL" \
      "$SPACESHIP_WIP_TEXT" \
      "$SPACESHIP_WIP_SUFFIX"
  fi
}

# setup the prompt!
# SPACESHIP_PROMPT_ORDER=(user host dir git wip package node elixir rust golang ruby venv pyenv line_sep char)
SPACESHIP_PROMPT_ORDER=(user host dir git wip package node elixir rust line_sep char)
SPACESHIP_ELIXIR_SYMBOL="🔮 "
SPACESHIP_CHAR_SYMBOL="➜ "

# enable some plugins...
plugins=(git wd asdf zsh-syntax-highlighting zsh-autosuggestions)

# let's get this party started!
source $ZSH/oh-my-zsh.sh

# --- utilities --- #

source ~/.zshcolors
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- aliases --- #

# general
alias ls='exa'
alias cat='bat'
alias config='vim ~/.zshrc'
alias reload='source ~/.zshrc'

# git
alias gc='git checkout'
alias gcb='git checkout -b'
alias gpu='git push'
alias gpl='git pull'
alias gpob='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gr='git rebase'
alias grc='git rebase --continue'
alias grh='git reset --hard HEAD'
alias gbd='git branch -D'
alias gcp='git cherry-pick'
alias gs='git status'
alias gl='git log'
alias gcf='git for-each-ref --format="%(refname:short)" refs/heads | fzf | xargs git checkout'

# elixir
alias iexm='iex -S mix'
alias phx='iex -S mix phx.server'

# househappy
alias gcbh='git rev-parse --abbrev-ref HEAD | rg -or \$1 "^(\d{7,10})-" | sed "s/$/] /" | sed "s/^/[#/" | tr -d "\n" | pbcopy; echo "Copied to clipboard!"'

# --- path --- #

export PATH=$PATH:~/.local/bin

