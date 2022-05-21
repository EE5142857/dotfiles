#!/bin/bash
# sudo vi /etc/apt/sources.list
# :%s/# deb-src/deb-src
sudo apt update
sudo apt build-dep vim
sudo apt install build-essential
sudo apt install python3-dev
cd /usr/local/src/
git clone --depth 1 https://github.com/vim/vim.git
