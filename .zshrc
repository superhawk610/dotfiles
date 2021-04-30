export ZSH_DISABLE_COMPFIX=true

# extended initialization -----

if [ -d "$HOME/.zshrc.d" ]
then
  for f in ~/.zshrc.d/*; do
    source $f
  done
fi

