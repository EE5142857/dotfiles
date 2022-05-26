@echo off

set PYTHON_VERSION=3.9
set ENV_PATH="C:\work\win_venv\myenv"

:main
    cd /d %~dp0

    if not exist %ENV_PATH% (
        py -%PYTHON_VERSION% -m venv %ENV_PATH%
    )

    call %ENV_PATH%\Scripts\activate.bat
    pip config --site set global.trusted-host "pypi.org pypi.python.org files.pythonhosted.org"
    pip install -U pip
    pip install wheel
    pip install -r requirements.txt

    echo Done.
    pause
exit /b
