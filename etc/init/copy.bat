@echo off

:main
    chcp 65001>nul
    cd /d %~dp0..\..

    copy "%cd%\.vim\init.vim"           "%USERPROFILE%\.vimrc"
    copy "%cd%\.vim\local_sample.vim"   "%USERPROFILE%\.vim\local_sample.vim"
    copy "%cd%\.vim\autoload"           "%USERPROFILE%\.vim\autoload"
    copy "%cd%\.vim\ftdetect"           "%USERPROFILE%\.vim\ftdetect"
    copy "%cd%\vscode\settings.json"    "%APPDATA%\Code\User\settings.json"
    copy "%cd%\.vim\vsnip"              "%APPDATA%\Code\User\snippets"
    copy "%cd%\.gitignore"              "%USERPROFILE%\.gitignore"

    echo Done.
    pause
exit /b
