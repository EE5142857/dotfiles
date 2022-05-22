#!/bin/bash
set -euo pipefail
cd `dirname $0`
# sudo vi /etc/apt/sources.list
# :%s/# deb-src/deb-src
sudo apt -y install ripgrep
sudo apt -y install zip
curl -fsSL https://deno.land/install.sh | bash
echo "export DENO_INSTALL=\"~/.deno\"" >> ~/.profile
echo "PATH=\"\$DENO_INSTALL/bin:\$PATH\"" >> ~/.profile
source ~/.profile
sudo apt -y build-dep vim
sudo apt -y install build-essential
sudo apt -y install python3-dev
cd /usr/local/src
sudo git clone --depth 1 https://github.com/vim/vim.git
