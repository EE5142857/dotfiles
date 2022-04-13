@echo off
@REM Run as administrator.

:main
    cd /d %~dp0..\..

    mkdir "%LOCALAPPDATA%\nvim-data"
    mkdir "%USERPROFILE%\scoop\persist\vscode\data\user-data\User"
    mkdir "%APPDATA%\Code\User"

    @REM copy

    call :my_mklink "%USERPROFILE%\.vimrc"      "%cd%\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\_vimrc"      "%cd%\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\.vim"        "%cd%\.vim"
    call :my_mklink "%USERPROFILE%\vimfiles"    "%cd%\.vim"
    call :my_mklink "%LOCALAPPDATA%\nvim"       "%cd%\.vim"
    call :my_mklink "%USERPROFILE%\scoop\persist\vscode\data\user-data\User\settings.json"^
                                                "%cd%\vscode\settings.json"
    call :my_mklink "%APPDATA%\Code\User\settings.json"^
                                                "%cd%\vscode\settings.json"
    call :my_mklink "%USERPROFILE%\scoop\persist\vscode\data\user-data\User\snippets"^
                                                "%cd%\.vim\vsnip"
    call :my_mklink "%APPDATA%\Code\User\snippets"^
                                                "%cd%\.vim\vsnip"
    call :my_mklink "%USERPROFILE%\.gitignore"  "%cd%\.gitignore"

    @REM git config --global user.name foo
    @REM git config --global user.email foo@bar.com
    git config --global core.editor vim
    git config --global core.excludesfile ~/.gitignore
    git config --global diff.compactionHeuristic true
    git config --global diff.tool vimdiff
    git config --global difftool.prompt false
    git config --global difftool.vimdiff.path vim
    git config --global http.sslVerify false
    git config --global merge.conflictstyle diff3
    git config --global merge.tool vimdiff
    git config --global mergetool.prompt false
    git config --global mergetool.vimdiff.path vim

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
