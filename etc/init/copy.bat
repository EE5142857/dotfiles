@echo off

:main
    cd /d %~dp0..\..

    mkdir "%USERPROFILE%\.vim\autoload"
    mkdir "%USERPROFILE%\.vim\ftdetect"

    copy "%cd%\.vim\init.vim"           "%USERPROFILE%\.vimrc"
    copy "%cd%\.vim\autoload"           "%USERPROFILE%\.vim\autoload"
    copy "%cd%\.vim\ftdetect"           "%USERPROFILE%\.vim\ftdetect"
    copy "%cd%\.gitignore"              "%USERPROFILE%\.gitignore"

    echo Done.
    pause
exit /b
