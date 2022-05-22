#!/bin/bash
set -euo pipefail
cd `dirname $0`
if [ -n "$(which wslpath)" ]; then
  ln -sd /mnt/c/work ~/work
  sudo ln -s ~/work/dotfiles/wsl.conf /etc/wsl.conf
fi
ln -sd ~/work/dotfiles/.vim ~/.vim
ln -s ~/work/dotfiles/.vimrc ~/.vimrc
CONFDIR=~/.config
if [ ! -e ${CONFDIR} ]; then
  mkdir ${CONFDIR}
fi
ln -sd ~/work/dotfiles/.vim ${CONFDIR}/nvim
ln -s ~/work/dotfiles/.gitignore ~/.gitignore
