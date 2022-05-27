#!/bin/bash
set -euo pipefail
cd `dirname $0`
if [ -n "$(which wslpath)" ]; then
  ln -sd /mnt/c/work ${HOME}/work
  sudo ln -s /mnt/c/work/dotfiles/wsl.conf /etc/wsl.conf
fi
ln -sd /mnt/c/work/dotfiles/.vim ${HOME}/.vim
ln -s /mnt/c/work/dotfiles/.vimrc ${HOME}/.vimrc
CONFDIR="${HOME}/.config"
mkdir -p ${CONFDIR}
ln -sd /mnt/c/work/dotfiles/.vim ${CONFDIR}/nvim
ln -s /mnt/c/work/dotfiles/.gitignore ${HOME}/.gitignore
ln -s /mnt/c/work/dotfiles/.bashrc ${HOME}/.my_bashrc
