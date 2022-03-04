@echo off
@REM Run as administrator.

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
    call :my_rmdir_del "%APPDATA%\Code"
    call :my_rmdir_del "%USERPROFILE%\.vscode"

    @REM Make directories.
    mkdir "%APPDATA%\Code\User"

    @REM Make symbolic links.
    call :my_mklink "%APPDATA%\Code\User\settings.json"     "%~dp0..\..\Code\User\settings.json"
    call :my_mklink "%APPDATA%\Code\User\keybindings.json"  "%~dp0..\..\Code\User\keybindings.json"
    call :my_mklink "%APPDATA%\Code\User\snippets"          "%~dp0..\..\Code\User\snippets"

    @REM Install VSCode extensions.
    @REM code --list-extensions
    for /f "tokens=1,* delims=," %%i in (code_--list-extensions.txt) do (
        call :install_vscode_extension "%%i"
    )

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

@REM :my_mklink %destination_path% %source_path%
:my_mklink
    @REM Check if %source_path% is a file or a directory.
    dir "%~2" | findstr /c:"<DIR>">nul
    if %ERRORLEVEL% equ 0 (
        @REM It is a directory.
        mklink /d "%~1" "%~2"
    ) else (
        @REM It is a file.
        mklink "%~1" "%~2"
    )
exit /b

@REM :install_vscode_extension %id%
:install_vscode_extension
    @REM set cur_dir=%cd%
    @REM cd /d "%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\bin"
    call code --install-extension %~1
    @REM cd /d %cur_dir%
    timeout /t 5
exit /b