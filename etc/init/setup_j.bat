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
    cd /d %~dp0..\..

    call :my_rmdir_del "%USERPROFILE%\.vim"
    call :my_rmdir_del "%USERPROFILE%\.vimrc"
    call :my_rmdir_del "%USERPROFILE%\_vimrc"
    call :my_rmdir_del "%USERPROFILE%\.viminfo"
    call :my_rmdir_del "%USERPROFILE%\_viminfo"
    call :my_rmdir_del "%APPDATA%\Code\User"
    call :my_rmdir_del "%USERPROFILE%\.gitignore"
    call :my_rmdir_del "%cd%\bin"
    call :my_rmdir_del "%cd%\doc"
    call :my_rmdir_del "%cd%\etc"
    call :my_rmdir_del "%cd%\README.md"

    REM mkdir "%APPDATA%\Code\User"
    REM 
    REM @REM copy
    REM 
    REM call :my_mklink "%USERPROFILE%\.vimrc"      "%cd%\.vim\init.vim"
    REM call :my_mklink "%USERPROFILE%\_vimrc"      "%cd%\.vim\init.vim"
    REM call :my_mklink "%USERPROFILE%\.vim"        "%cd%\.vim"
    REM call :my_mklink "%USERPROFILE%\vimfiles"    "%cd%\.vim"
    REM call :my_mklink "%LOCALAPPDATA%\nvim"       "%cd%\.vim"
    REM call :my_mklink "%APPDATA%\Code\User\settings.json"^
    REM                                             "%cd%\vscode\settings.json"
    REM call :my_mklink "%APPDATA%\Code\User\snippets"^
    REM                                             "%cd%\.vim\vsnip"
    REM call :my_mklink "%USERPROFILE%\.gitignore"  "%cd%\.gitignore"
    REM 
    REM @REM git config --global user.name foo
    REM @REM git config --global user.email foo@bar.com
    REM git config --global core.editor vim
    REM git config --global core.excludesfile ~/.gitignore
    REM git config --global diff.compactionHeuristic true
    REM git config --global diff.tool vimdiff
    REM git config --global difftool.prompt false
    REM git config --global difftool.vimdiff.path vim
    REM git config --global merge.conflictstyle diff3
    REM git config --global merge.tool vimdiff
    REM git config --global mergetool.prompt false
    REM git config --global mergetool.vimdiff.path vim

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