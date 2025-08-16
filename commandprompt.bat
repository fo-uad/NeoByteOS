@echo off
title NeoByte OS - Command Promt
cls
color 0f

:: Startup Banner
echo ==================================================
echo          Welcome to NeoByte OS - Command Shell   
echo ==================================================
echo Type "help" for a list of commands.
echo.

:main
set /p "cmd=NeoByteOS> "

:: Command handlers
if /i "%cmd%"=="help" goto help
if /i "%cmd%"=="about" goto about
if /i "%cmd:~0,4%"=="log(" goto log
if /i "%cmd%"=="date" goto showdate
if /i "%cmd%"=="time" goto showtime
if /i "%cmd%"=="clear" goto clear
if /i "%cmd%"=="dir" goto listdir
if /i "%cmd%"=="exit" goto exit
if /i "%cmd%"=="" goto main

echo Unknown command: %cmd%
goto main

:help
echo.
echo ----------- Available Commands -----------
echo about          - About NeoByte OS prompt
echo log("msg")     - Print a message to the screen
echo date           - Show current date
echo time           - Show current time
echo clear          - Clear the screen
echo dir            - List files in current folder
echo exit           - Exit NeoByte OS
echo -------------------------------------------
echo.
goto main

:about
echo.
echo NeoByte OS prompt - Minimalistic Batch Command prompt
echo Designed for speed, clarity, and style.
echo.
goto main

:log
:: Extract message inside log("...")
set "msg=%cmd:~4%"
set "msg=%msg:~1,-2%"
echo %msg%
goto main

:showdate
echo.
date /t
echo.
goto main

:showtime
echo.
time /t
echo.
goto main

:clear
cls
goto main

:listdir
echo text.txt
echo script.bat
echo config.ini
echo desktop.ini
echo README.txt
echo welcome.txt
echo docs.pdf
goto main

:exit
cls
echo Closing NeoByte OS Command prompt...
timeout /t 2 >nul
call "NeoByteOS.bat"