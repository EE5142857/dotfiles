@echo off

set PYTHON_VERSION=3.10
set ENV_PATH="C:\work\win_venv\myenv"

:main
    cd /d %~dp0

    if not exist %ENV_PATH% (
        py -%PYTHON_VERSION% -m venv %ENV_PATH%
    )

    call %ENV_PATH%\Scripts\activate.bat
    pip3 config --site set global.trusted-host "pypi.org pypi.python.org files.pythonhosted.org"
    pip3 install -U pip
    pip3 install wheel
    pip3 install -r requirements.txt

    echo Done.
    pause
exit /b
