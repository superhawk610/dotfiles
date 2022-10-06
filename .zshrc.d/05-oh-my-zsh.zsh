# oh-my-zsh setup

export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="starship" (set at end of .zshrc)


plugins=(
  # automatically update all custom plugins with `omz update`
  # git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate
  autoupdate
  wd
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  asdf
)

source $ZSH/oh-my-zsh.sh
