#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

cd /usr/local/src/vim
sudo git pull
cd ./src
sudo make uninstall
sudo make distclean
sudo ./configure                    \
--disable-gui                       \
--enable-fail-if-missing            \
--enable-python3interp=dynamic      \
--prefix=/usr/local                 \
--with-features=huge                \
--with-x
sudo make
sudo make install
hash -r
