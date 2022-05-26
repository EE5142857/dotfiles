#!/bin/bash
set -euo pipefail
cd `dirname $0`
ENV_PATH="${HOME}/work/venv/myenv"
mkdir -p "${HOME}/work/venv"
python3.10 -m venv ${ENV_PATH}
. ${ENV_PATH}/bin/activate
# pip3 config --site set global.trusted-host "pypi.org pypi.python.org files.pythonhosted.org"
pip3 install -U pip3
pip3 install wheel
pip3 install -r requirements.txt
deactivate
