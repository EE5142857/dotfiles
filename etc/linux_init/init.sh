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
# bash nvim_init.sh
# bash nvim_build.sh
bash python310_init.sh
bash python310_venv_myenv.sh
bash clean.sh
bash symlink.sh
echo "Restart to finish installing"
