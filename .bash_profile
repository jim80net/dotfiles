#!/usr/bin/env bash

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

eval "$(starship init bash)"

for i in $(ls ${HOME}/.bash_profile.d/*.sh); do
  source $i
done

