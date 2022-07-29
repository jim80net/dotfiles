#!/usr/bin/env bash
# install.sh - Used by VS Code / GitHub to automatically setup devcontainer / codespaces

for i in $(ls $HOME/dotfiles/.bash_profile.d/*.sh); do source $i; done

# I'm assuming I'm checked out to ~/dotfiles

LISTOFILES=".gitconfig .gitignore"

for i in ${LISTOFILES}; do
  ln -s $HOME/dotfiles/$i $HOME/$i
done