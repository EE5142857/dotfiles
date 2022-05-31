#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")" || exit

rm -rf "${HOME}"/.cache
rm -rf "${HOME}"/.config/nvim
rm -rf "${HOME}"/.gitignore
rm -rf "${HOME}"/.my_bashrc
rm -rf "${HOME}"/.vim
rm -rf "${HOME}"/.viminfo
rm -rf "${HOME}"/.vimrc
rm -rf "${HOME}"/jupytext.yml
if [ -n "$(which wslpath)" ]; then
  rm -rf "${HOME}"/work
  sudo rm -rf /etc/wsl.conf
fi
