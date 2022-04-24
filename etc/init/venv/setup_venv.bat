@echo off

set PYTHON="python39"
set DIR_PATH="C:\work"
set ENV_NAME="myenv"

:main
    cd /d %DIR_PATH%

    if not exist %ENV_NAME% (
        %PYTHON% -m venv %ENV_NAME%
    )

    call %ENV_NAME%\Scripts\activate.bat
    pip config --site set global.trusted-host "pypi.org pypi.python.org files.pythonhosted.org"
    pip install -U pip

    for /f %%i in (%~dp0\requirements.txt) do (
        call :pip_install "%%i"
    )

    echo Done.
    pause
exit /b

@REM :pip_install %module%
:pip_install
    pip install %~1
exit /b
