@echo off

:main
    taskkill /f /im explorer.exe
    timeout /t 1
    del /f /s /q /a %LOCALAPPDATA%\IconCache.db
    del /f /s /q /a %LOCALAPPDATA%\microsoft\Windows\Explorer\thumbcache*.db
    del /f /s /q /a %LOCALAPPDATA%\microsoft\Windows\Explorer\iconcache*.db
    start explorer.exe
    pause
exit /b
