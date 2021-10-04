@echo off

set EXECUTE_COMMIT_PUSH=1

@REM Create mylist.txt in the same directory.
@REM mylist.txt
@REM    ;path
@REM    ...
@REM    ...

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
    set cur_dir=%cd%

    for /f %%i in (mylist.txt) do (
        cd /d %%i

        echo ****************************************
        call git config --get remote.origin.url
        call :my_git_fetch
        call :my_git_command "merge"    "Your branch is behind"

        if %EXECUTE_COMMIT_PUSH% equ 1 (
            call git diff
            call :my_git_command "add -A"   "Untracked files"
            call :my_git_command "add -A"   "Changes not staged for commit"
            call :my_git_command "commit"   "Changes to be committed"
            call :my_git_command "push"     "Your branch is ahead of"
        )

        cd /d %cur_dir%
    )
    pause
exit /b

:my_git_fetch
    @REM Get the local HEAD hash.
    call git rev-parse HEAD>%filename%.log
    set /p hash_local=<%filename%.log
    del /q %filename%.log>nul 2>&1

    call git fetch

    @REM Get the remote HEAD hash.
    call git rev-parse HEAD>%filename%.log
    set /p hash_remote=<%filename%.log
    del /q %filename%.log>nul 2>&1

    @REM NOTE: Does it work?
    if %hash_local%==%hash_remote% (
        @REM Display the differences between %hash_local% and %hash_remote%.
        call git diff %hash_local%..%hash_remote%

        @REM Display commit logs from %hash_local% to %hash_remote%.
        call git log -p --stat --graph %hash_local%...%hash_remote%
    )
exit /b

@REM :my_git_command %command% %match_str%
:my_git_command
    call git status>%filename%.log

    setlocal enabledelayedexpansion
        findstr /c:"%~2" %filename%.log>nul
        @REM If "git status" includes %match_str%, execute git %command%.
        if !ERRORLEVEL! equ 0 (
            @REM Display "git status".
            type %filename%.log

            @REM Execute %command%.
            choice /c yn /m "Do you %~1?"
            if !ERRORLEVEL! equ 1 (
                call git %~1
            )
        )
    endlocal

    del /q %filename%.log>nul 2>&1
exit /b
