#!/usr/bin/env bash

# Used by VS Code to automatically setup dev container
for i in $(ls $HOME/dotfiles/.bash_profile.d/*.sh); do source $i; done
