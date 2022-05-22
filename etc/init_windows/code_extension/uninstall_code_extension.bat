@echo off

:main
    chcp 65001>nul
    cd /d %~dp0

    call code --list-extensions>uninstall.txt

    for /f %%i in (uninstall.txt) do (
        call :code_uninstall_extension "%%i"
    )
    del /q uninstall.txt>nul 2>&1

    echo Done.
    pause
exit /b

@REM :code_uninstall_extension %id%
:code_uninstall_extension
    call code --uninstall-extension %~1
exit /b
