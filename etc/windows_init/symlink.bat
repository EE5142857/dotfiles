@REM @echo off
@REM Run as administrator.

:main
    cd /d %~dp0
    call clean.bat
    mkdir "%APPDATA%\Code\User"

    cd /d %~dp0..\..
    mklink      "%USERPROFILE%\.vimrc"              "%cd%\.vimrc"
    mklink      "%USERPROFILE%\_vimrc"              "%cd%\.vimrc"
    mklink /d   "%USERPROFILE%\.vim"                "%cd%\.vim"
    mklink /d   "%USERPROFILE%\vimfiles"            "%cd%\.vim"
    mklink /d   "%LOCALAPPDATA%\nvim"               "%cd%\.vim"
    mklink      "%APPDATA%\Code\User\settings.json" "%cd%\.vscode\settings.json"
    mklink /d   "%APPDATA%\Code\User\snippets"      "%cd%\.vim\vsnip"
    mklink      "%USERPROFILE%\.gitignore"          "%cd%\.gitignore"
    mklink      "%USERPROFILE%\.wslconfig"          "%cd%\.wslconfig"
    pause
exit /b
