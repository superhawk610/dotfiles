export ZSH_DISABLE_COMPFIX=true

# determine OS ----------------

if [ "$OSTYPE" = "linux-gnu" ]; then
  export OS="linux"
elif [ "$OSTYPE" = "darwin" ]; then
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

# extended initialization -----

if [ -d "$HOME/.zshrc.d" ]
then
  for f in ~/.zshrc.d/*; do
    source $f
  done
fi

