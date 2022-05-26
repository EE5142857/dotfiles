#!/bin/bash
set -euo pipefail
cd `dirname $0`
ENV_PATH="${HOME}/work/venv/myenv"
mkdir -p "${HOME}/work/venv"
python3 -m venv ${ENV_PATH}
. ${ENV_PATH}/bin/activate
pip config --site set global.trusted-host "pypi.org pypi.python.org files.pythonhosted.org"
pip install -U pip
pip install wheel
pip install -r python3_venv_myenv_req.txt
deactivate
