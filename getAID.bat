@echo off
Call :GetSerialNumber
echo %SerialNumber%
reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\services\CSAgent\Sim" /f "AG" > "%userprofile%\documents\%SerialNumber%_falcon.txt"
robocopy %userprofile%\documents\ "\\path\to\destination" %SerialNumber%_falcon.txt /MOVE
Exit
::***********************************************

:GetSerialNumber
for /f "tokens=2 delims==" %%a in ('
    wmic csproduct get identifyingnumber /value
') do for /f "delims=" %%b in ("%%a") do (
    Set "SerialNumber=%%b" 
)
exit /b
::***********************************************
