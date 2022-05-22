#!/bin/bash
set -euo pipefail
cd `dirname $0`
if [ -n "$(which wslpath)" ]; then
  ln -sd /mnt/c/work ~/work
fi
ln -sd /mnt/c/work/dotfiles/.vim ~/.vim
ln -s /mnt/c/work/dotfiles/.vimrc ~/.vimrc
CONFDIR=~/.config
if [ ! -e ${CONFDIR} ]; then
  mkdir ${CONFDIR}
fi
ln -sd /mnt/c/work/dotfiles/.vim ${CONFDIR}/nvim
ln -s /mnt/c/work/dotfiles/.gitignore ~/.gitignore
