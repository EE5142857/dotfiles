#!/bin/bash
# set -euo pipefail
cd "$(dirname "$0")" || exit

lines="$(cat code_extension.txt | wc -l)"
for i in $(seq 1 "${lines}")
do
  extension="$(sed -n "${i}"p code_extension.txt)"
  echo "Installing ${i}"/"${lines}"
  code --install-extension "${extension}"
  echo ""
done
