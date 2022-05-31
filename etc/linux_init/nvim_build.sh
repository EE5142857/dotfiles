#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")" || exit

cd /usr/local/src/neovim || exit
sudo git checkout stable
sudo make CMAKE_BUILD_TYPE=Release \
  CMAKE_INSTALL_PREFIX=/usr/local/bin/nvim install
