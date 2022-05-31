#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

while read line
do
  code --install-extension "${line}"
  sleep 1
done < code_extension.txt
