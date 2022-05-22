#!/bin/bash
# git clone --depth 1 https://github.com/EE5142857/dotfiles
cd `dirname $0`
./symlink.sh
./git.sh
./app.sh
./build_vim.sh
