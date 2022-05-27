#!/bin/bash
set -euo pipefail
cd `dirname $0`
rm -rf ${HOME}/work
rm -rf ${HOME}/.vim
rm -rf ${HOME}/.vimrc
rm -rf ${HOME}/.config/nvim
rm -rf ${HOME}/.gitignore
rm -rf ${HOME}/.my_bashrc
rm -rf ${HOME}/.cache
rm -rf ${HOME}/.viminfo
if [ -n "$(which wslpath)" ]; then
  sudo rm -rf /etc/wsl.conf
fi
