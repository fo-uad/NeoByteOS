@echo off
setlocal enabledelayedexpansion

set "configFile=boot_choice.cfg"
set "colorFile=color_settings.cfg"
set "passwordFile=password.cfg"

:: Load boot choice if exists
if exist "%configFile%" (
    set /p bootChoice=<"%configFile%"
) else (
    set "bootChoice=Not Set"
)

:: Load colors if exists
if exist "%colorFile%" (
    for /f "tokens=1,2 delims=," %%A in (%colorFile%) do (
        set "textColor=%%A"
        set "bgColor=%%B"
    )
) else (
    set "textColor=7"
    set "bgColor=0"
)

:: Load password if exists
if exist "%passwordFile%" (
    for /f "tokens=1,2 delims=," %%A in (%passwordFile%) do (
        set "passwordEnabled=%%A"
        set "savedPassword=%%B"
    )
) else (
    set "passwordEnabled=0"
    set "savedPassword="
)

:MainMenu
cls
echo === Settings ===
echo Current Boot Mode: %bootChoice%
echo.
echo 1. Boot Settings
echo 2. Colors
echo 3. Information
echo 4. Password
echo 5. Exit Settings
echo.
set /p choice="Choose an option: "
if "%choice%"=="1" goto BootSettings
if "%choice%"=="2" goto ColorMenu
if "%choice%"=="3" goto Information
if "%choice%"=="4" goto Password
if "%choice%"=="5" goto ExitSettings
goto MainMenu

:Password
cls
set "passwordFile=password.cfg"
if not defined passwordEnabled set "passwordEnabled=0"

echo === Password Settings ===
echo Current Password Enabled: %passwordEnabled%
echo.
echo 1. Enable Password
echo 2. Disable Password
echo 3. Change Password
echo 4. Back
echo.
set /p passChoice="Choose an option: "

:: Enable Password
if "%passChoice%"=="1" (
    cls
    set /p newPassword="Enter new password: "
    echo 1,%newPassword%> "%passwordFile%"
    set "passwordEnabled=1"
    set "savedPassword=%newPassword%"
    echo Password enabled.
    pause
    goto MainMenu
)

:: Disable Password
if "%passChoice%"=="2" (
    if exist "%passwordFile%" del "%passwordFile%"
    set "passwordEnabled=0"
    set "savedPassword="
    echo Password disabled and file removed.
    pause
    goto MainMenu
)

:: Enable delayed expansion for this section
setlocal enabledelayedexpansion

:: Change Password
if "%passChoice%"=="3" (
    cls
    if exist "%passwordFile%" (
        :: Read current password from file
        for /f "tokens=1,2 delims=," %%A in (%passwordFile%) do (
            set "savedFlag=%%A"
            set "savedPassword=%%B"
        )
        
        :: Ask user to enter current password
        set /p currentPassword="Enter current password: "
        
        :: Compare using delayed expansion
        if "!currentPassword!"=="!savedPassword!" (
            set /p newPassword="Enter new password: "
            :: Save new password in 1,password format
            echo 1,!newPassword!> "%passwordFile%"
            set "savedPassword=!newPassword!"
            set "passwordEnabled=1"
            echo Password changed successfully.
        ) else (
            echo Incorrect current password.
        )
    ) else (
        echo No password set. Please enable first.
    )
    pause
    goto MainMenu
)
endlocal



:: Back to Main Menu
if "%passChoice%"=="4" goto MainMenu

goto Password


:Information
cls
echo === Information ===
echo Boot Mode: %bootChoice%
echo Text Color: %textColor%
echo Background Color: %bgColor%
echo.
echo ===This is NeoByteOS Settings.===
echo.
echo NeoByte OS -- A sleek, next-generation command-line OS combining minimalism with modern speed.
echo Reviving the power of bytes for a faster, cleaner, and smarter computing experience.
pause
goto MainMenu

:BootSettings
cls
echo === Boot Settings ===
echo Current Boot Mode: %bootChoice%
echo.
echo 1. Set Fast Boot
echo 2. Set Normal Boot
echo 3. Reset to Boot Menu
echo 4. Back
echo.
set /p bootChoiceSel="Choose an option: "
if "%bootChoiceSel%"=="1" (
    echo fast> "%configFile%"
    set "bootChoice=fast"
    echo Boot mode set to Fast Boot. Restarting...
    timeout /t 2 >nul
    echo Restart NeoByteOS.bat to apply changes.
    pause >nul
)
if "%bootChoiceSel%"=="2" (
    echo normal> "%configFile%"
    set "bootChoice=normal"
    echo Boot mode set to Normal Boot. Restarting...
    timeout /t 2 >nul
    echo Restart NeoByteOS.bat to apply changes.
    pause >nul
)
if "%bootChoiceSel%"=="3" (
    del "%configFile%" 2>nul
    set "bootChoice=Not Set"
    echo Boot menu will appear on next start.
    timeout /t 2 >nul
    start "" "%~dp0NeoByteOS.bat"
    exit
)
if "%bootChoiceSel%"=="4" goto MainMenu
goto BootSettings

:ColorMenu
cls
echo === Colors ===
echo Current Text Color: %textColor%
echo Current Background Color: %bgColor%
echo.
echo 1. Text Color
echo 2. Background Color
echo 3. Back
echo.
set /p colChoice="Choose an option: "
if "%colChoice%"=="1" goto TextColor
if "%colChoice%"=="2" goto BgColor
if "%colChoice%"=="3" goto MainMenu
goto ColorMenu

:TextColor
cls
echo === Text Color ===
echo 1. White (7)
echo 2. Light Green (A)
echo 3. Light Blue (9)
echo 4. Custom (0-F)
echo 5. Back
echo.
set /p txtChoice="Choose an option: "
if "%txtChoice%"=="1" set "textColor=7" & goto SaveColors
if "%txtChoice%"=="2" set "textColor=A" & goto SaveColors
if "%txtChoice%"=="3" set "textColor=9" & goto SaveColors
if "%txtChoice%"=="4" (
    set /p custom="Enter custom text color hex (0-F): "
    set "custom=!custom:~0,1!"
    set "textColor=!custom!"
    goto SaveColors
)
if "%txtChoice%"=="5" goto ColorMenu
goto TextColor

:BgColor
cls
echo === Background Color ===
echo 1. Black (0)
echo 2. Blue (1)
echo 3. Green (2)
echo 4. Custom (0-F)
echo 5. Back
echo.
set /p bgChoice="Choose an option: "
if "%bgChoice%"=="1" set "bgColor=0" & goto SaveColors
if "%bgChoice%"=="2" set "bgColor=1" & goto SaveColors
if "%bgChoice%"=="3" set "bgColor=2" & goto SaveColors
if "%bgChoice%"=="4" (
    set /p custom="Enter custom background color hex (0-F): "
    set "custom=!custom:~0,1!"
    set "bgColor=!custom!"
    goto SaveColors
)
if "%bgChoice%"=="5" goto ColorMenu
goto BgColor

:SaveColors
:: Apply color
set "colorCode=%bgColor%%textColor%"
color %colorCode%
:: Save colors to file as textColor,bgColor
echo %textColor%,%bgColor%> "%colorFile%"
goto ColorMenu

:ExitSettings
exit
