#!/bin/bash
set -euo pipefail
cd `dirname $0`

PY_VER=3.10
ENV_PATH="${HOME}/work/venv/myenv"

mkdir -p "${HOME}/work/venv"

python${PY_VER} -m venv ${ENV_PATH}
. ${ENV_PATH}/bin/activate
python${PY_VER} -m pip install -U pip
python${PY_VER} -m pip install wheel
python${PY_VER} -m pip install -r requirements.txt
deactivate
