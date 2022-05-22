@REM @echo off
@REM Run as administrator.

:main
    cd /d %~dp0..\..

    mkdir "%APPDATA%\Code\User"

    @REM mklink      "%USERPROFILE%\.vimrc"              "%cd%\.vimrc"
    @REM mklink      "%USERPROFILE%\_vimrc"              "%cd%\.vimrc"
    @REM mklink /d   "%USERPROFILE%\.vim"                "%cd%\.vim"
    @REM mklink /d   "%USERPROFILE%\vimfiles"            "%cd%\.vim"
    @REM mklink /d   "%LOCALAPPDATA%\nvim"               "%cd%\.vim"
    mklink      "%APPDATA%\Code\User\settings.json" "%cd%\.vscode\settings.json"
    mklink /d   "%APPDATA%\Code\User\snippets"      "%cd%\.vim\vsnip"
    mklink      "%USERPROFILE%\.gitignore"          "%cd%\.gitignore"
    mklink      "%USERPROFILE%\.wslconfig"          "%cd%\.wslconfig"
    pause
exit /b
