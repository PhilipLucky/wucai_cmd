@echo off
setlocal

set "WUCAI_CMD=%APPDATA%\npm\wucai.cmd"

if not exist "%WUCAI_CMD%" (
    echo [wucai.bat] Missing command: "%WUCAI_CMD%"
    exit /b 1
)

start "" cmd /k call "%WUCAI_CMD%"
