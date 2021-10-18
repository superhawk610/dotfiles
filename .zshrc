export ZSH_DISABLE_COMPFIX=true
export TERM=xterm-256color

# determine OS ----------------

if [ "$OSTYPE" = "linux-gnu" ]; then
  export OS="linux"
# Mac's OS string sometimes contains a trailing version
elif echo "$OSTYPE" | grep -q -E "^darwin"; then
  export OS="mac"
else
  export OS="unknown"
fi

on_mac() {
  [ "$OS" = "mac" ]
}

on_linux() {
  [ "$OS" = "linux" ]
}

on_wsl() {
  [ -f "/proc/version" ] && grep -qEi '(Microsoft|WSL)' /proc/version
}

# extended initialization -----

if [ -d "$HOME/.zshrc.d" ]
then
  for f in ~/.zshrc.d/*; do
    source $f
  done
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
