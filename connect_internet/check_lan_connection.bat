@setlocal enableextensions enabledelayedexpansion
@echo off

timeout 30 >nul

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
call "connect_wifi.bat"
) else (
call "disconnect_wifi.bat"
)
ping -n 6 127.0.0.1 >nul: 2>nul:

endlocal