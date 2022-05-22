#!/bin/bash
cd `dirname $0`
if [-n "$(which wslpath)"]; then
  unlink ~/work
fi
unlink ~/.vim
unlink ~/.vimrc
unlink ~/.config/nvim
unlink ~/.gitignore
rm -rf ~/.viminfo
rm -rf ~/.cache
