#!/bin/bash
set -eo pipefail

# Github Codespaces bootstrap

DOTFILES=$(dirname $1)
echo "linking against $DOTFILES"

echo "setting up home directory"
mkdir -p "${HOME}/.zshrc.d"
mkdir -p "${HOME}/.config/nvim"

echo "linking files"
ln -S "${DOTFILES}/.gitconfig"              "${HOME}/.gitconfig"
ln -S "${DOTFILES}/.zshrc"                  "${HOME}/.zshrc"
ln -S "${DOTFILES}/.zshrc.d/00-minimal.zsh" "${HOME}/.zshrc.d/00-minimal.zsh"
ln -S "${DOTFILES}/.zshrc.d/10-aliases.zsh" "${HOME}/.zshrc.d/10-aliases.zsh"
ln -S "${DOTFILES}/.config/nvim/init.vim"   "${HOME}/.config/nvim/init.vim"

echo "done!"

