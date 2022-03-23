@echo off
@REM Run as administrator.

:main
    chcp 65001>nul
    cd /d %~dp0..\..

    @REM Make directories.
    mkdir "%LOCALAPPDATA%\nvim-data"
    mkdir "%USERPROFILE%\scoop\persist\vscode\data\user-data\User"

    @REM Copy files.
    copy ".\.gitconfig"     "%USERPROFILE%\.gitconfig"
    copy ".\.gitignore"     "%USERPROFILE%\.gitignore"

    @REM Make symbolic links.
    call :my_mklink "%USERPROFILE%\.vimrc"      ".\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\_vimrc"      ".\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\.vim"        ".\.vim"
    call :my_mklink "%USERPROFILE%\vimfiles"    ".\.vim"
    call :my_mklink "%LOCALAPPDATA%\nvim"       ".\.vim"
    call :my_mklink "%USERPROFILE%\scoop\persist\vscode\data\user-data\User\settings.json"^
                                                ".\.vscode\settings.json"
    call :my_mklink "%USERPROFILE%\markdown_style.css"^
                                                ".\doc\markdown_style.css"

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
