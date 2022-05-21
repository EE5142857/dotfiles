@echo off

set yyyy=%date:~0,4%
set mm=%date:~5,2%
set dd=%date:~8,2%
set time00=%time: =0%
set hh=%time00:~0,2%
set mn=%time00:~3,2%
set ss=%time00:~6,2%
set ff=%time00:~9,2%
set filename=%yyyy%-%mm%-%dd%T%hh%-%mn%-%ss%-%ff%

:main
    chcp 65001>nul
    cd /d %~dp0

    call code --list-extensions>%filename%.txt

    for /f %%i in (%filename%.txt) do (
        call :code_uninstall_extension "%%i"
    )
    del /q %filename%.txt>nul 2>&1

    echo Done.
    pause
exit /b

@REM :code_uninstall_extension %id%
:code_uninstall_extension
    call code --uninstall-extension %~1
exit /b
