@echo off

:main
    cd /d %~dp0..\..

    mkdir "%USERPROFILE%\.vim\autoload"
    mkdir "%USERPROFILE%\.vim\ftdetect"
    mkdir "%APPDATA%\Code\User\snippets"

    copy "%cd%\.vim\init.vim"           "%USERPROFILE%\.vimrc"
    copy "%cd%\.vim\autoload"           "%USERPROFILE%\.vim\autoload"
    copy "%cd%\.vim\ftdetect"           "%USERPROFILE%\.vim\ftdetect"
    copy "%cd%\vscode\settings.json"    "%APPDATA%\Code\User\settings.json"
    copy "%cd%\.vim\vsnip"              "%APPDATA%\Code\User\snippets"
    copy "%cd%\.gitignore"              "%USERPROFILE%\.gitignore"

    echo Done.
    pause
exit /b
