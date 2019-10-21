#!/bin/bash

echo "Are you sure?[y,n]"
read answer

[[ "$answer" == "y" ]] && {
  rm -rf ~/.emacs.d
  ln -s $(pwd)/.emacs.d ~/.emacs.d
} || {
  exit 1
}
