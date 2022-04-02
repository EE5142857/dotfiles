@echo off
@REM Run as administrator.

set yyyy=%date:~0,4%
set mm=%date:~5,2%
set dd=%date:~8,2%
set time00=%time: =0%
set hh=%time00:~0,2%
set mn=%time00:~3,2%
set ss=%time00:~6,2%
set ff=%time00:~9,2%
set filename=%yyyy%-%mm%-%dd%T%hh%-%mn%-%ss%-%ff%

:main
    chcp 65001>nul
    cd /d %~dp0

    mkdir "%APPDATA%\Code\User"

    @REM copy

    call :my_mklink "%USERPROFILE%\.vimrc"      "%cd%\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\_vimrc"      "%cd%\.vim\init.vim"
    call :my_mklink "%USERPROFILE%\.vim"        "%cd%\.vim"
    call :my_mklink "%USERPROFILE%\vimfiles"    "%cd%\.vim"
    call :my_mklink "%LOCALAPPDATA%\nvim"       "%cd%\.vim"
    call :my_mklink "%APPDATA%\Code\User\settings.json"^
                                                "%cd%\vscode\settings.json"
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
    git config --global merge.conflictstyle diff3
    git config --global merge.tool vimdiff
    git config --global mergetool.prompt false
    git config --global mergetool.vimdiff.path vim

    echo Done.
    pause
exit /b

@REM :my_rmdir_del %path%
:my_rmdir_del
    echo Removing %~1...

    setlocal enabledelayedexpansion
        @REM Check if %path% exist.
        dir "%~1">%filename%.log 2>&1

        findstr /c:"File Not Found" %filename%.log>nul 2>&1

        if not !ERRORLEVEL! equ 0 (
            @REM Check if it is a file or a directory.
            findstr /r /c:"\<DIR\>[ ]*\." %filename%.log>nul 2>&1
            if !ERRORLEVEL! equ 0 (
                @REM It is a directory.
                rmdir /q /s "%~1"
            ) else (
                @REM It is a file
                del /q "%~1"
            )
        ) else (
            echo Not Found
        )

        del /q %filename%.log>nul 2>&1
    endlocal
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
