#!/bin/bash
cd `dirname $0`
if [-n "$(which wslpath)"]; then
  ln -sd  /mnt/c/work               ~/work
fi
ln -sd  ~/dotfiles/.vim           ~/.vim
ln -s   ~/dotfiles/.vimrc         ~/.vimrc
ln -sd  ~/dotfiles/.vim           ~/.config/nvim
ln -s   ~/dotfiles/.gitignore     ~/.gitignore
