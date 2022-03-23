@echo off

:main
    chcp 65001>nul
    cd /d %~dp0

    npm install -g mermaid.cli

    echo Done.
    pause
exit /b

