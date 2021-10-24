@echo off

:main
    chcp 65001>nul
    cd /d C:\work
    call myenv\Scripts\activate.bat
    jupyter lab
exit /b
