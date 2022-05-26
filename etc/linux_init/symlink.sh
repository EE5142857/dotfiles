#!/bin/bash
set -euo pipefail
cd `dirname $0`
if [ -n "$(which wslpath)" ]; then
  ln -sd /mnt/c/work ${HOME}/work
  sudo ln -s ${HOME}/work/dotfiles/wsl.conf /etc/wsl.conf
fi
ln -sd ${HOME}/work/dotfiles/.vim ${HOME}/.vim
ln -s ${HOME}/work/dotfiles/.vimrc ${HOME}/.vimrc
CONFDIR="${HOME}/.config"
mkdir -p ${CONFDIR}
ln -sd ${HOME}/work/dotfiles/.vim ${CONFDIR}/nvim
ln -s ${HOME}/work/dotfiles/.gitignore ${HOME}/.gitignore
ln -s ${HOME}/work/dotfiles/.bashrc ${HOME}/.my_bashrc
