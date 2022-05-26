#!/bin/bash
set -euo pipefail
cd `dirname $0`
sudo apt update
sudo apt install build-essential libbz2-dev libdb-dev \
libreadline-dev libffi-dev libgdbm-dev liblzma-dev    \
libncursesw5-dev libsqlite3-dev libssl-dev            \
zlib1g-dev uuid-dev tk-dev
cd /usr/local/src
sudo wget https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tar.xz
sudo tar xJf Python-3.10.4.tar.xz
cd Python-3.10.4
sudo ./configure
sudo make
sudo make install
hash -r
