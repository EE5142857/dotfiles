#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")" || exit

# sudo apt -y update
sudo apt -y install build-essential libbz2-dev libdb-dev libreadline-dev  \
  libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev      \
  libssl-dev zlib1g-dev uuid-dev tk-dev
cd /usr/local/src || exit
sudo wget https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tar.xz
sudo tar xJf Python-3.10.4.tar.xz
cd Python-3.10.4 || exit
sudo ./configure
sudo make
sudo make altinstall
hash -r
