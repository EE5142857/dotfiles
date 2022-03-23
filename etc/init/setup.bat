@echo off
@REM Run as administrator.

:main
    chcp 65001>nul
    cd /d %~dp0..\..

    mkdir "%LOCALAPPDATA%\nvim-data"
    mkdir "%USERPROFILE%\scoop\persist\vscode\data\user-data\User"

    @REM copy

    call :my_mklink "%USERPROFILE%\.vimrc"      "%cd%\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\_vimrc"      "%cd%\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\.vim"        "%cd%\.vim"
    call :my_mklink "%USERPROFILE%\vimfiles"    "%cd%\.vim"
    call :my_mklink "%LOCALAPPDATA%\nvim"       "%cd%\.vim"
    call :my_mklink "%USERPROFILE%\scoop\persist\vscode\data\user-data\User\settings.json"^
                                                "%cd%\.vscode\settings.json"
    call :my_mklink "%USERPROFILE%\.gitignore"  "%cd%\.gitignore"
    call :my_mklink "%USERPROFILE%\markdown_style.css"^
                                                "%cd%\doc\markdown_style.css"

    @REM git config --global user.name foo
    @REM git config --global user.email foo@bar.com
    git config --global core.editor vim
    git config --global core.excludesfile ~/.gitignore
    git config --global diff.compactionHeuristic true

    echo Done.
    pause
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
