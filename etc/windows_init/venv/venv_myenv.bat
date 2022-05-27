@echo off
@REM Run as user.

set PY_VER=3.10
set ENV_PATH="C:\work\win_venv\myenv"

:main
    cd /d %~dp0

    if not exist %ENV_PATH% (
        py -%PY_VER% -m venv %ENV_PATH%
    )

    cd %ENV_PATH%
    call .\Scripts\activate.bat
    pip config --site set global.trusted-host "pypi.org pypi.python.org files.pythonhosted.org"
    @REM pip install -U pip
    pip install wheel
    pip install -r requirements.txt
    deactivate

    echo Done.
    pause
exit /b
