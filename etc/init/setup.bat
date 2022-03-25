@echo off
@REM Run as administrator.

:main
    chcp 65001>nul
    cd /d %~dp0..\..

    mkdir "%LOCALAPPDATA%\nvim-data"
    mkdir "%USERPROFILE%\scoop\persist\vscode\data\user-data\User"
    mkdir "%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"

    @REM copy

    call :my_mklink "%USERPROFILE%\.vimrc"      "%cd%\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\_vimrc"      "%cd%\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\.vim"        "%cd%\.vim"
    call :my_mklink "%USERPROFILE%\vimfiles"    "%cd%\.vim"
    call :my_mklink "%LOCALAPPDATA%\nvim"       "%cd%\.vim"
    call :my_mklink "%USERPROFILE%\scoop\persist\vscode\data\user-data\User\settings.json"^
                                                "%cd%\vscode\settings.json"
    call :my_mklink "%USERPROFILE%\.gitignore"  "%cd%\.gitignore"

    @REM git config --global user.name foo
    @REM git config --global user.email foo@bar.com
    git config --global core.editor nvim
    git config --global core.excludesfile ~/.gitignore
    git config --global diff.compactionHeuristic true
    git config --global diff.tool vimdiff
    git config --global difftool.vimdiff.path nvim
    git config --global difftool.prompt false
    git config --global merge.tool vimdiff
    git config --global mergetool.vimdiff.path nvim
    git config --global mergetool.prompt false

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
