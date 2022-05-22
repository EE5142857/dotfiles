#!/bin/bash
set -euo pipefail
cd `dirname $0`
rm -rf ~/work
rm -rf ~/.cache
rm -rf ~/.vim
rm -rf ~/.vimrc
rm -rf ~/.viminfo
rm -rf ~/.config/nvim
rm -rf ~/.gitignore
if [ -n "$(which wslpath)" ]; then
  sudo rm -rf /etc/wsl.conf
fi
