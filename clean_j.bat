@echo off

:main
    chcp 65001>nul
    cd /d %~dp0

    call :my_rmdir_del "%USERPROFILE%\.vim"
    call :my_rmdir_del "%USERPROFILE%\.vimrc"
    call :my_rmdir_del "%USERPROFILE%\_vimrc"
    call :my_rmdir_del "%USERPROFILE%\.viminfo"
    call :my_rmdir_del "%USERPROFILE%\_viminfo"
    call :my_rmdir_del "%APPDATA%\Code\User"
    call :my_rmdir_del "%USERPROFILE%\.gitignore"
    call :my_rmdir_del "%cd%\bin"
    call :my_rmdir_del "%cd%\doc"
    call :my_rmdir_del "%cd%\etc"
    call :my_rmdir_del "%cd%\.vim\rc"
    call :my_rmdir_del "%cd%\.vim\ginit.vim"
    call :my_rmdir_del "%cd%\README.md"

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

