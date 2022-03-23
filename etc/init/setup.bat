@echo off
@REM Run as administrator.

:main
    chcp 65001>nul
    cd /d %~dp0..\..

    @REM Make directories.
    mkdir "%LOCALAPPDATA%\nvim-data"
    mkdir "%USERPROFILE%\scoop\persist\vscode\data\user-data\User"

    @REM Copy files.
    copy "%cd%\.gitconfig" "%USERPROFILE%\.gitconfig"
    copy "%cd%\.gitignore" "%USERPROFILE%\.gitignore"

    @REM Make symbolic links.
    call :my_mklink "%USERPROFILE%\.vimrc"      "%cd%\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\_vimrc"      "%cd%\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\.vim"        "%cd%\.vim"
    call :my_mklink "%USERPROFILE%\vimfiles"    "%cd%\.vim"
    call :my_mklink "%LOCALAPPDATA%\nvim"       "%cd%\.vim"
    call :my_mklink "%USERPROFILE%\scoop\persist\vscode\data\user-data\User\settings.json"^
                                                "%cd%\.vscode\settings.json"
    call :my_mklink "%USERPROFILE%\markdown_style.css"^
                                                "%cd%\doc\markdown_style.css"

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
