@echo off
setlocal enabledelayedexpansion

set "configFile=boot_choice.cfg"
set "passwordFile=password.cfg"
set "passwordEnabled=0"
set "password="

:: Load password if exists
if exist "%passwordFile%" (
    for /f "tokens=1,2 delims=," %%A in (%passwordFile%) do (
        set "passwordEnabled=%%A"
        set "password=%%B"
    )
) else (
    :: Default to disabled
    set "passwordEnabled=0"
    set "password="
)

:: Only check .cfg on first startup
if not defined BOOT_MODE (
    if exist "%configFile%" (
        set /p bootChoice=<"%configFile%"
        set "bootChoice=!bootChoice: =!"
        if /i "!bootChoice!"=="fast" set "BOOT_MODE=fast" & goto fastbootcheck
        if /i "!bootChoice!"=="normal" set "BOOT_MODE=normal" & goto normalbootcheck
    )
)

:start
cls
title NeoByte OS Boot Menu
color 9f
echo Choose boot option
echo.
echo 1. Fast boot
echo 2. Normal boot
echo 3. Safe boot
set /p opt=">"
if "%opt%"=="exit" exit
if "%opt%"=="1" (
    echo fast > "%configFile%"
    set "BOOT_MODE=fast"
    goto fastbootcheck
)
if "%opt%"=="2" (
    echo normal > "%configFile%"
    set "BOOT_MODE=normal"
    goto normalbootcheck
)
if "%opt%"=="3" goto safeboot
goto start

:safeboot
title NeoByte OS Safe Boot
cls
color 0f
timeout 2 >nul
echo Loading Resources...
timeout 6 >nul
echo Safe Boot
echo want to fix NeoByte OS? you are in the right place
echo.
echo 1. Reboot
echo 2. Shutdown
set /p safeboot="Safe Boot Option: "
if "%safeboot%"=="1" goto start
if "%safeboot%"=="2" exit

:fastbootcheck
if "%passwordEnabled%"=="1" goto PasswordPrompt
goto fastboot

:normalbootcheck
if "%passwordEnabled%"=="1" goto PasswordPrompt
goto normalboot

:PasswordPrompt
cls
set /p userPass="Enter password: "
if "%userPass%"=="%password%" (
    echo Access Granted.
    timeout 1 >nul
    if "%BOOT_MODE%"=="fast" goto fastboot
    if "%BOOT_MODE%"=="normal" goto normalboot
) else (
    echo Incorrect password!
    timeout 2 >nul
    goto start
)

:fastboot
title NeoByte OS Fast Boot
cls
color 0f
timeout 2 >nul
echo Loading Resources...
timeout 1 >nul
echo Loading Desktop...
timeout 1 >nul
goto desktopfast

:normalboot
title NeoByte OS
cls
color 0f
timeout 2 >nul
echo Loading Resources...
timeout 4 >nul
echo Loading Desktop...
timeout 5 >nul
goto desktop

:desktop
cls
echo desktop
echo.
echo 1. Notepad
echo 2. command prompt
echo 3. File Explorer
echo 4. Settings
echo 5. Reboot
echo 6. Shutdown
set /p desk=">"
if "%desk%"=="1" call notepad.bat
if "%desk%"=="2" call commandprompt.bat
if "%desk%"=="3" call explorer.bat
if "%desk%"=="4" call settings.bat
if "%desk%"=="5" goto %BOOT_MODE%boot
if "%desk%"=="6" echo exiting...
timeout 3 >nul & exit
goto desktop

:desktopfast
cls
echo desktop
echo.
echo 1. Notepad
echo 2. Settings
echo 3. Reboot
echo 4. Shutdown
set /p deskfast=">"
if "%deskfast%"=="1" call notepad.bat
if "%deskfast%"=="2" call settings.bat
if "%deskfast%"=="3" goto %BOOT_MODE%boot
if "%deskfast%"=="4" echo exiting...
timeout 1 >nul & exit
goto desktopfast
