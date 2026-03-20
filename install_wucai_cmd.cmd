@echo off
setlocal

set "APP_PATH_KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\wucai.exe"
set "SCRIPT_DIR=%~dp0"
if "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
set "WUCAI_EXE=%SCRIPT_DIR%\wucai.exe"

if not exist "%WUCAI_EXE%" goto missing_exe

reg add "%APP_PATH_KEY%" /ve /t REG_SZ /d "%WUCAI_EXE%" /f >nul 2>&1
if errorlevel 1 goto reg_failed

reg add "%APP_PATH_KEY%" /v Path /t REG_SZ /d "%SCRIPT_DIR%" /f >nul 2>&1
if errorlevel 1 goto reg_failed

echo.
echo wucai_cmd installation completed.
echo Registered EXE:
echo %WUCAI_EXE%
echo Please close and reopen Explorer windows before testing.
echo.
set /p EXIT_PROMPT=Press Enter to exit...
exit /b 0

:missing_exe
echo.
echo [install_wucai_cmd.cmd] Missing file:
echo %WUCAI_EXE%
echo.
set /p EXIT_PROMPT=Installation failed. Press Enter to exit...
exit /b 1

:reg_failed
echo.
echo [install_wucai_cmd.cmd] Failed to write registry.
echo.
set /p EXIT_PROMPT=Installation failed. Press Enter to exit...
exit /b 1
