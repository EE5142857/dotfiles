@echo off

:main
    chcp 65001>nul
    cd /d %~dp0

    @REM code --list-extensions
    for /f "tokens=1,* delims=," %%i in (code_extensions.txt) do (
        call :code_install_extension "%%i"
    )

    echo Done.
    pause
exit /b

@REM :code_install_extension %id%
:code_install_extension
    call code --install-extension %~1
    timeout /t 5
exit /b
