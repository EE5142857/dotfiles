#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")" || exit

sudo apt -y update
cd "${HOME}" || exit
wget https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh
bash Anaconda3-2022.05-Linux-x86_64.sh
conda config --append channels conda-forge
conda config --set auto_activate_base false
conda update --all
# conda env create -y -f foo.yml
conda info -e
