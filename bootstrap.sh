#!/bin/bash
set -eo pipefail

# Github Codespaces bootstrap

DOTFILES=$(dirname $1)
echo "linking against $DOTFILES"

echo "setting up home directory"
mkdir -p "${HOME}/.config/nvim"

echo "linking files"
ln -S "${DOTFILES}/.gitconfig"              "${HOME}/.gitconfig"
ln -S "${DOTFILES}/.config/nvim/init.lua"   "${HOME}/.config/nvim/init.lua"

echo "done!"
