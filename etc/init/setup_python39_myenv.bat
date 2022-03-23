@echo off

:main
    chcp 65001>nul
    cd /d %~dp0..\..\..

    python39 -m venv myenv
    call myenv\Scripts\activate.bat
    pip install -U pip
    pip install pip-review
    pip install jupyterlab pynvim jupytext ipykernel
    pip install numpy matplotlib pandas scikit-learn
    pip install flake8

    echo Done.
    pause
exit /b
