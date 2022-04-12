@echo off

:main
    cd /d C:\work
    call myenv\Scripts\activate.bat
    jupyter-lab
exit /b
