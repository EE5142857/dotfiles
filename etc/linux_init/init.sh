#!/bin/bash
set -euo pipefail
cd `dirname $0`
bash clean.sh
bash git.sh
bash app.sh
bash vim_init.sh
bash vim_build.sh
bash symlink.sh
