#!/bin/bash
set -euo pipefail
cd `dirname $0`
unlink ${HOME}/work
unlink ${HOME}/.vim
unlink ${HOME}/.vimrc
unlink ${HOME}/.config/nvim
unlink ${HOME}/.gitignore
unlink ${HOME}/.my_bashrc
rm -rf ${HOME}/.cache
rm -rf ${HOME}/.viminfo
if [ -n "$(which wslpath)" ]; then
  sudo unlink /etc/wsl.conf
fi
