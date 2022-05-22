#!/bin/bash
# cd
# git clone --depth 1 https://github.com/EE5142857/dotfiles
# cd /mnt/c/work
# sudo git clone --depth 1 https://github.com/EE5142857/dotfiles
set -euo pipefail
cd `dirname $0`
bash clean.sh
bash git.sh
bash app.sh
bash vim_init.sh
bash vim_build.sh
bash symlink.sh
