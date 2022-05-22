@REM @echo off

:main
    cd /d %~dp0
    del /q      "%USERPROFILE%\.vimrc"
    del /q      "%USERPROFILE%\_vimrc"
    del /q      "%USERPROFILE%\.viminfo"
    del /q      "%USERPROFILE%\_viminfo"
    rmdir /q /s "%USERPROFILE%\.cache"
    rmdir /q /s "%USERPROFILE%\.vim"
    rmdir /q /s "%USERPROFILE%\vimfiles"
    rmdir /q /s "%LOCALAPPDATA%\nvim"
    rmdir /q /s "%LOCALAPPDATA%\nvim-data"
    rmdir /q /s "%APPDATA%\Code\User"
    rmdir /q /s "%USERPROFILE%\.vscode"
    del /q      "%USERPROFILE%\.gitignore"
    del /q      "%USERPROFILE%\.wslconfig"
    pause
exit /b
