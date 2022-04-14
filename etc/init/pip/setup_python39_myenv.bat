@echo off

:main
    cd /d %~dp0..\..\..

    python39 -m venv ..\myenv
    copy "%cd%\etc\init\pip.ini" "%cd%\..\myenv\pip.ini"
    call ..\myenv\Scripts\activate.bat
    pip install -U pip
    pip install pip-review
    pip install jupyterlab pynvim jupytext ipykernel
    pip install numpy matplotlib pandas scikit-learn
    pip install python-lsp-server

    echo Done.
    pause
exit /b
