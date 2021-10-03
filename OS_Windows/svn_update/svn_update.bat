@echo off

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
    @REM In order to avoid log file encoding error, chcp should be shiftjis.
    @REM chcp 65001>nul
    cd /d %~dp0
    set cur_dir=%cd%

    for /f %%i in (mylist.txt) do (
        cd /d %%i
        call :my_svn_update %%i
        cd /d %cur_dir%
    )

    pause
exit /b

@REM :my_svn_update %path%
:my_svn_update
    echo ****************************************
    call svn info --show-item url

    @REM Get the local HEAD revision.
    call svn info --show-item revision>%filename%.log
    set /p rev_local=<%filename%.log
    del /q %filename%.log>nul 2>&1

    call svn update>nul

    @REM Get the remote HEAD revision.
    call svn info --show-item revision>%filename%.log
    set /p rev_remote=<%filename%.log
    del /q %filename%.log>nul 2>&1

    if %rev_local% lss %rev_remote% (
        echo Updated.

        @REM Display commit logs from %rev_local% to %revision_after%
        call svn log -v -r %rev_local%:%rev_remote%>%filename%.log
        type %filename%.log
        del /q %filename%.log>nul 2>&1
    ) else (
        echo Already up-to-date.
    )
exit /b
