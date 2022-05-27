@echo off
@REM Run as user.

set PY_VER=3.10
set ENV_PATH="C:\work\win_venv\myenv"

:main
    cd /d %~dp0

    if not exist %ENV_PATH% (
        py -%PY_VER% -m venv %ENV_PATH%
    )

    call %ENV_PATH%\Scripts\activate.bat
    python -m pip config --site set global.trusted-host "pypi.org pypi.python.org files.pythonhosted.org"
    python -m pip install -U pip
    python -m pip install wheel
    python -m pip install -r ..\linux_init\requirements.txt
    @REM deactivate

    echo Done.
    pause
exit /b
