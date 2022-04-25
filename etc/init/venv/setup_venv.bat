@echo off

set PYTHON="python39"
set ENV_PATH="C:\work\myenv"

:main
    cd /d %~dp0

    if not exist %ENV_PATH% (
        %PYTHON% -m venv %ENV_PATH%
    )

    call %ENV_PATH%\Scripts\activate.bat
    pip config --site set global.trusted-host "pypi.org pypi.python.org files.pythonhosted.org"
    pip install -U pip
    pip install -r requirements.txt

    echo Done.
    pause
exit /b
