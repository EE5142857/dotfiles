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

    @REM Remove files/directories.
    call :my_rmdir_del "%USERPROFILE%\.vim"
    call :my_rmdir_del "%USERPROFILE%\vimfiles"
    call :my_rmdir_del "%USERPROFILE%\.vimrc"
    call :my_rmdir_del "%USERPROFILE%\_vimrc"
    call :my_rmdir_del "%USERPROFILE%\.viminfo"
    call :my_rmdir_del "%USERPROFILE%\_viminfo"
    call :my_rmdir_del "%LOCALAPPDATA%\nvim"
    call :my_rmdir_del "%LOCALAPPDATA%\nvim-data"
    call :my_rmdir_del "%USERPROFILE%\scoop\persist\vscode\data\user-data\User"
    call :my_rmdir_del "%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
    call :my_rmdir_del "%USERPROFILE%\.gitignore"
    call :my_rmdir_del "%USERPROFILE%\markdown_style.css"

    echo Done.
    pause
exit /b

@REM :my_rmdir_del %path%
:my_rmdir_del
    echo Removing %~1...

    setlocal enabledelayedexpansion
        @REM Check if %path% exist.
        dir "%~1">%filename%.log 2>&1

        findstr /c:"File Not Found" %filename%.log>nul 2>&1

        if not !ERRORLEVEL! equ 0 (
            @REM Check if it is a file or a directory.
            findstr /r /c:"\<DIR\>[ ]*\." %filename%.log>nul 2>&1
            if !ERRORLEVEL! equ 0 (
                @REM It is a directory.
                rmdir /q /s "%~1"
            ) else (
                @REM It is a file
                del /q "%~1"
            )
        ) else (
            echo Not Found
        )

        del /q %filename%.log>nul 2>&1
    endlocal
exit /b
