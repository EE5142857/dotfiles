@echo off
@REM Run as administrator.

:main
    cd /d %~dp0..\..

    mkdir "%APPDATA%\Code\User"

    call :my_mklink "%USERPROFILE%\.vimrc"      "%cd%\.vimrc"
    call :my_mklink "%USERPROFILE%\_vimrc"      "%cd%\.vimrc"
    call :my_mklink "%USERPROFILE%\.vim"        "%cd%\.vim"
    call :my_mklink "%USERPROFILE%\vimfiles"    "%cd%\.vim"
    call :my_mklink "%APPDATA%\Code\User\settings.json"^
                                                "%cd%\.vscode\settings.json"
    call :my_mklink "%APPDATA%\Code\User\snippets"^
                                                "%cd%\.vim\vsnip"
    call :my_mklink "%USERPROFILE%\.gitignore"  "%cd%\.gitignore"

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
