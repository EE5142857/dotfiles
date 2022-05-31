#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

if [ -n "$(which wslpath)" ]; then
  sudo ln -s /mnt/c/work/dotfiles/wsl.conf /etc/wsl.conf
  ln -s /mnt/c/work "${HOME}"/work
  ln -s /mnt/c/work/dotfiles/.bashrc "${HOME}"/.my_bashrc
  ln -s /mnt/c/work/dotfiles/.gitignore "${HOME}"/.gitignore
  ln -s /mnt/c/work/dotfiles/.vim "${HOME}"/.vim
  ln -s /mnt/c/work/dotfiles/.vimrc "${HOME}"/.vimrc
  ln -s /mnt/c/work/dotfiles/jupytext.yml "${HOME}"/jupytext.yml
  # CONFDIR="${HOME}"/.config
  # mkdir -p "${CONFDIR}"
  # ln -s /mnt/c/work/dotfiles/.vim "${CONFDIR}"/nvim
fi
