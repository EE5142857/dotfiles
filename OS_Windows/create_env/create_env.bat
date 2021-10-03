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
    for /f %%i in (rmdir_del.txt) do (
        call :my_rmdir_del "%%i"
    )

    @REM Make directories.
    for /f %%i in (mkdir.txt) do (
        call :my_mkdir "%%i"
    )

    @REM Make symbolik links.
    for /f "tokens=1-3 delims=," %%i in (mklink.txt) do (
        call :my_mklink "%%i" "%%j" "%%k"
    )

    @REM Git global settings
    for /f "delims=" %%i in (..\..\Git\init_cmd.txt) do (
        call %%i
    )

    @REM Install VSCode extensions.
    for /f %%i in (..\..\Code\extensions.txt) do (
        call :install_vscode_extension %%i
    )

    @REM Install Vim plugins with dein.vim.
    vim

    echo Done.
    pause
exit /b

@REM :my_rmdir_del %path%
:my_rmdir_del
    echo Removing %~1...

    setlocal enabledelayedexpansion
        @REM Check if %path% exist.
        dir "%~1">%filename%.log
        findstr /c:"File(s)" %filename%.log>nul

        if !ERRORLEVEL! equ 0 (
            @REM Check if it is a file or a directory.
            findstr /r /c:"\<DIR\>[ ]*\." %filename%.log>nul
            if !ERRORLEVEL! equ 0 (
                @REM It is a directory.
                rmdir /q /s "%~1"
            ) else (
                @REM It is a file.
                del /q "%~1"
            )
        )

        del /q %filename%.log>nul 2>&1
    endlocal
exit /b

@REM :my_mkdir %path%
:my_mkdir
    mkdir "%~1"
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
    call code --install-extension %~1
exit /b
