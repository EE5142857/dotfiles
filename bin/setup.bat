@echo off
@REM Run as administrator.

:main
    chcp 65001>nul
    cd /d %~dp0

    @REM Make directories.
    mkdir "%LOCALAPPDATA%\nvim-data"
    mkdir "%USERPROFILE%\scoop\persist\vscode\data\user-data\User"

    @REM Copy files.
    copy "..\sample.gitconfig"  "%USERPROFILE%\.gitconfig"
    copy "..\sample.gitignore"  "%USERPROFILE%\.gitignore"

    @REM Make symbolic links.
    call :my_mklink "%USERPROFILE%\.vimrc"                  "%~dp0..\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\.vim"                    "%~dp0..\.vim"
    call :my_mklink "%USERPROFILE%\vimfiles"                "%~dp0..\.vim"
    call :my_mklink "%LOCALAPPDATA%\nvim"                   "%~dp0..\.vim"
    call :my_mklink "%USERPROFILE%\scoop\persist\vscode\data\user-data\User\settings.json"     "%~dp0..\.vscode\settings.json"
    call :my_mklink "%USERPROFILE%\scoop\persist\vscode\data\user-data\User\keybindings.json"  "%~dp0..\.vscode\keybindings.json"
    call :my_mklink "%USERPROFILE%\scoop\persist\vscode\data\user-data\User\snippets"          "%~dp0..\.vscode\snippets"
    call :my_mklink "%USERPROFILE%\markdown_style.css"      "%~dp0..\markdown_style.css"

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
