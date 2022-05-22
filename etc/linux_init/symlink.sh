#!/bin/bash
set -euo pipefail
cd `dirname $0`
if [ -n "$(which wslpath)" ]; then
  ln -sd /mnt/c/work ~/work
  sudo ln -s ~/dotfiles/wsl.conf /etc/wsl.conf
fi
ln -sd ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
CONFDIR=~/.config
if [ ! -e ${CONFDIR} ]; then
  mkdir ${CONFDIR}
fi
ln -sd ~/dotfiles/.vim ${CONFDIR}/nvim
ln -s ~/dotfiles/.gitignore ~/.gitignore
