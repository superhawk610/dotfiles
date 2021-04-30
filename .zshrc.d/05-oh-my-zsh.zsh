# oh-my-zsh setup

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

