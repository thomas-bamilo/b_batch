@echo off
setlocal EnableDelayedExpansion
rem set threshold value
set _threshold=100

rem get the battery charge
rem use findstr to strip blank lines from wmic output
for /f "usebackq skip=1 tokens=1" %%i in (`wmic Path Win32_Battery Get EstimatedChargeRemaining ^| findstr /r /v "^$"`) do (
  set _charge=%%i
  echo !_charge!
  echo !_charge! > last_battery_level.txt
  if !_charge! lss !_threshold! (
    echo threshold reached
    echo !_charge! > last_battery_level.txt 
    CALL "goemail.exe"
    ) 
	
  )
quit