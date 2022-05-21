@REM @echo off

:main
    cd /d %~dp0

    del /q      "%USERPROFILE%\.vimrc"
    del /q      "%USERPROFILE%\_vimrc"
    del /q      "%USERPROFILE%\.viminfo"
    del /q      "%USERPROFILE%\_viminfo"
    rmdir /q /s "%USERPROFILE%\.cache\dein"
    rmdir /q /s "%USERPROFILE%\.vim"
    rmdir /q /s "%USERPROFILE%\vimfiles"
    rmdir /q /s "%LOCALAPPDATA%\nvim"
    rmdir /q /s "%LOCALAPPDATA%\nvim-data"
    rmdir /q /s "%APPDATA%\Code\User"
    rmdir /q /s "%USERPROFILE%\.vscode"
    del /q      "%USERPROFILE%\.wslconfig"
    del /q      "%USERPROFILE%\.gitignore"

    pause
exit /b