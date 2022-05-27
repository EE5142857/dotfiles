#!/bin/bash
set -euo pipefail
cd `dirname $0`
PYTHON_VER=3.10
ENV_PATH="${HOME}/work/venv/myenv"
mkdir -p "${HOME}/work/venv"
python${PYTHON_VER} -m venv ${ENV_PATH}
. ${ENV_PATH}/bin/activate
# python${PYTHON_VER} -m pip config --site set global.trusted-host "pypi.org pypi.python.org files.pythonhosted.org"
python${PYTHON_VER} -m pip install -U pip
python${PYTHON_VER} -m pip install wheel
python${PYTHON_VER} -m pip install -r requirements.txt
deactivate
