#!/bin/bash
set -euo pipefail
cd `dirname $0`
sudo apt install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
# sudo vim /etc/apt/sources.list -c "%s/# deb-src/deb-src" -c "wq"
# sudo apt update
cd /usr/local/src
sudo git clone https://github.com/neovim/neovim.git
echo "export PATH=\"/usr/local/neovim/bin:\${PATH}\"" >> ~/.profile
