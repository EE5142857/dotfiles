#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

# sudo apt -y install zip
if [ -z "$(which deno)" ]; then
  curl -fsSL https://deno.land/install.sh | bash
fi
# sudo vim /etc/apt/sources.list -c "%s/# deb-src/deb-src" -c "wq"
# sudo apt -y update
sudo apt -y build-dep vim
sudo apt -y install build-essential python3-dev
cd /usr/local/src
sudo git clone --depth 1 https://github.com/vim/vim.git
