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

rem if LAN is down, then check wifi, if wifi is down then connect to wifi

set ipaddrwifi=%1 172.20.0.24
:loopwifi
set statewifi=down
for /f "tokens=5,6,7" %%a in ('ping -n 1 !ipaddrwifi!') do (
    if "x%%b"=="xunreachable." goto :endloopwifi
    if "x%%a"=="xReceived" if "x%%c"=="x1,"  set statewifi=up
)
:endloopwifi
echo.Link is !statewifi!
if !statewifi! == down (
call "connect_wifi.bat"
)
ping -n 6 127.0.0.1 >nul: 2>nul:

) else (

rem if LAN is not down, then disconnect wifi

call "disconnect_wifi.bat"
)
ping -n 6 127.0.0.1 >nul: 2>nul:

endlocal