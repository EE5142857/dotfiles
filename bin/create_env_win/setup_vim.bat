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
    call :my_rmdir_del "%USERPROFILE%\.cache"
    call :my_rmdir_del "%USERPROFILE%\.vim"
    call :my_rmdir_del "%USERPROFILE%\vimfiles"
    call :my_rmdir_del "%USERPROFILE%\.vimrc"
    call :my_rmdir_del "%USERPROFILE%\_vimrc"
    call :my_rmdir_del "%LOCALAPPDATA%\nvim"
    call :my_rmdir_del "%LOCALAPPDATA%\nvim-data"
    call :my_rmdir_del "%USERPROFILE%\.gitconfig"
    call :my_rmdir_del "%USERPROFILE%\.gitignore"
    call :my_rmdir_del "%USERPROFILE%\markdown_style.css"

    @REM Make directories.
    mkdir "%LOCALAPPDATA%\nvim-data"

    @REM Make files.
    type nul>%~dp0..\..\Vim\.vim\.netrwbook
    type nul>%~dp0..\..\Vim\.vim\.netrwhist

    @REM Make symbolic links.
    call :my_mklink "%USERPROFILE%\.vimrc"                  "%~dp0..\..\Vim\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\.vim"                    "%~dp0..\..\Vim\.vim"
    call :my_mklink "%USERPROFILE%\vimfiles"                "%~dp0..\..\Vim\.vim"
    call :my_mklink "%LOCALAPPDATA%\nvim"                   "%~dp0..\..\Vim\.vim"
    call :my_mklink "%LOCALAPPDATA%\nvim-data\.netrwbook"   "%~dp0..\..\Vim\.vim\.netrwbook"
    call :my_mklink "%LOCALAPPDATA%\nvim-data\.netrwhist"   "%~dp0..\..\Vim\.vim\.netrwhist"
    call :my_mklink "%USERPROFILE%\.gitignore"              "%~dp0..\..\.gitignore"
    call :my_mklink "%USERPROFILE%\markdown_style.css"      "%~dp0..\..\markdown_style.css"

    @REM Git global settings
    @REM call git config --global user.name foo
    @REM call git config --global user.email foo@bar.com
    call git config --global core.editor nvim
    call git config --global core.excludesfile %USERPROFILE%\.gitignore
    call git config --global credential.helper manager-core
    call git config --global diff.compactionHeuristic true

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
    set cur_dir=%cd%
    cd /d "%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\bin"
    call code --install-extension %~1
    cd /d %cur_dir%
    timeout /t 5
exit /b
