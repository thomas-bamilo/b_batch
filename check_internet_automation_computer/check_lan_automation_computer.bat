@setlocal enableextensions enabledelayedexpansion
@echo off
set ipaddr=%1 192.168.11.133
:loop
set state=down
for /f "tokens=5,6,7" %%a in ('ping -n 1 !ipaddr!') do (
    if "x%%b"=="xunreachable." goto :endloop
    if "x%%a"=="xReceived" if "x%%c"=="x1,"  set state=up
)
:endloop
echo.Link is !state!
if !state! == down (
call "goemailapp.exe"
timeout 180 >nul
call "lan_and_wifi_failure\check_wifi_automation_computer.bat")
ping -n 6 127.0.0.1 >nul: 2>nul:

endlocal