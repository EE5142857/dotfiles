#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

sudo apt -y update
sudo apt -y install postgresql postgresql-contrib
psql --version