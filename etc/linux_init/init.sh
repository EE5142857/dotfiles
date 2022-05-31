#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")" || exit

bash clean.sh
bash git.sh
bash app.sh
bash vim_init.sh
bash vim_build.sh
# bash nvim_init.sh
# bash nvim_build.sh
bash python310_init.sh
bash python_venv_myenv.sh
bash anaconda_init.sh
bash postgresql_init.sh
bash r_init.sh
bash code_init.sh
bash clean.sh
bash symlink.sh
echo "Restart to finish installing"
