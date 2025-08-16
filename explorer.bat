@echo off
title NeoByteOS - Explorer
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Default report variables
set "username=User"
set "notes="

:: Load boot choice if exists
if exist "boot_choice.cfg" (
    set /p bootChoice=<boot_choice.cfg
) else (
    set "bootChoice=Default"
)

:: Load last User ID or start at 1
if exist "user_id.cfg" (
    set /p userID=<user_id.cfg
) else (
    set /a userID=1
)

:menu
cls
echo ===============================
echo      NeoByte OS Explorer
echo ===============================
echo.
echo  Fake Files:
echo  1. report.txt
echo  2. NeoByteOS.jpg
echo  3. music.mp3
echo  4. secret.docx
echo  5. exit
echo.
set /p choice=Select a file to 'open' (1-5): 

:: Main menu selections
if "!choice!"=="1" goto file1
if "!choice!"=="2" goto file2
if "!choice!"=="3" goto file3
if "!choice!"=="4" goto file4
if "!choice!"=="5" goto end
if /i "!choice!"=="dev.mode /on" goto enableDevMode
goto menu

:file1
cls
:: Increment User ID for this Explorer window
set /a userID+=1
:: Save updated User ID for next session
(echo !userID!)>user_id.cfg

:reportMenu
cls
echo ===============================
echo         report.txt
echo ===============================
echo.
echo OS Name: NeoByte OS
echo Version: 1.0.0
echo Build Date: 2025-08-16
echo.
echo User Info:
echo - Username: !username!
echo - User ID: !userID!
echo - Access Level: Standard
echo.
echo System Status:
echo - Boot Choice: !bootChoice!
echo - Memory Usage: 45%%
echo - CPU Usage: 12%%
echo - Disk Usage: 68%%
echo.
echo Installed Modules:
echo - Explorer Module
echo - Notepad Module
echo - Terminal Module
echo - Custom Commands Module
echo.
echo Recent Logs:
if defined notes (
    echo !notes!
) else (
    echo - No logs yet.
)
echo.
echo Notes:
if defined notes (
    setlocal enabledelayedexpansion
    set i=1
    for %%N in (!notes!) do (
        echo !i!. %%N
        set /a i+=1
    )
    endlocal
) else (
    echo - No notes yet.
)
echo.
echo  Options:
echo  1. Add Note
echo  2. Delete Note
echo  3. Change Username
echo  4. Back to Explorer
set /p rchoice=Choose an option (1-4): 

if "!rchoice!"=="1" goto addNote
if "!rchoice!"=="2" goto deleteNote
if "!rchoice!"=="3" goto changeUser
if "!rchoice!"=="4" goto menu
goto reportMenu

:addNote
:addNote
cls
set /p newnote=Enter your note: 
if defined notes (
    set "notes=!notes!;!newnote!"
) else (
    set "notes=!newnote!"
)
cls
echo Note added!
timeout /t 1 >nul
goto reportMenu
:deleteNote
cls
if not defined notes (
    echo No notes to delete!
    timeout /t 1 >nul
    goto reportMenu
)
setlocal enabledelayedexpansion
set i=1
for %%N in (!notes!) do (
    echo !i!. %%N
    set /a i+=1
)
endlocal
set /p delNote=Enter note number to delete: 
setlocal enabledelayedexpansion
set newNotes=
set i=1
for %%N in (!notes!) do (
    if not "!i!"=="!delNote!" (
        if defined newNotes (
            set "newNotes=!newNotes!;%%N"
        ) else (
            set "newNotes=%%N"
        )
    )
    set /a i+=1
)
endlocal
set "notes=!newNotes!"
cls
echo Note deleted!
timeout /t 1 >nul
goto reportMenu

:changeUser
cls
set /p username=Enter new username: 
cls
echo Username changed to !username!
timeout /t 1 >nul
goto reportMenu

:file2
cls
echo Opening NeoByteOS.jpg...
timeout /t 3 >nul
cls
echo ┌───────────────────────┐
echo │  ╔══════════════════╗ │
echo │ █║                  ║ │
echo │ █║                  ║ │
echo │ █║    NeoByte OS    ║ │
echo │ █║                  ║ │
echo │ █║                  ║ │
echo │  ╚══════════════════╝ │
echo └───────────────────────┘
pause
goto menu

:file3
cls
echo Playing music.mp3...
echo [Pretend music playing]
pause
goto menu

:file4
cls
echo Opening secret.docx...
timeout /t 2 >nul
cls
echo =========================
echo This document contains top secret information.
echo Top Secret: let's keep it secret!
timeout /t 2 >nul
echo Fo-uad made this OS
echo =========================
echo Type exit to return to Explorer.
:devMode
set /p dev="> "

if /i "!dev!"=="dev.mode /on" goto enableDevMode
if /i "!dev!"=="exit" (
    cls
    echo Returning to Explorer...
    timeout /t 1 >nul
    goto menu
)
echo Invalid command. Type "exit" to return.
timeout /t 2 >nul
goto devMode

:enableDevMode
cls
set /p devPass="Dev_mode password: "
:: Default dev mode password if not set
if not defined devModePassword set "devModePassword=G`b.X.-$wa3I@,X?/`>:abg4{NDMrd"
if "!devPass!"=="!devModePassword!" (
    cls
    echo Dev Mode enabled!
    timeout /t 1 >nul
    goto devModeLoop
) else (
    echo Incorrect password!
    timeout /t 2 >nul
    goto menu
)

:devModeLoop
cls
echo =========================
echo       DEV MODE ACTIVE
echo =========================
echo Type 'help' for commands.
set /p dev="> "

if /i "!dev!"=="dev.mode /off" (
    cls
    echo Returning to Explorer...
    timeout /t 1 >nul
    goto menu
) else if /i "!dev!"=="info" (
    echo NeoByte OS Dev Mode
    echo Version: 1.0.0
    echo Author: Fo-uad
    pause
    goto devModeLoop
) else if /i "!dev!"=="help" (
    cls
    echo Available commands:
    echo  info     - Show OS info
    echo  clear    - Clear the screen
    echo  notes    - Add/view dev notes
    echo  settings - Dev Mode settings
    echo  log      - Show dev log
    echo  dev.mode /off - Return to Explorer
    pause
    goto devModeLoop
) else if /i "!dev!"=="clear" (
    cls
    goto devModeLoop
) else if /i "!dev!"=="notes" (
    cls
    echo =========================
    echo       Dev Mode Notes
    echo =========================
    if defined notes (
        setlocal enabledelayedexpansion
        set i=1
        for %%N in (!notes!) do (
            echo !i!. %%N
            set /a i+=1
        )
        endlocal
    ) else (
        echo - No notes yet.
    )
    echo.
    echo 1. Add Note
    echo 2. Delete Note
    echo 3. Back
    set /p noteChoice="Choose an option: "
    if "!noteChoice!"=="1" (
        set /p newNote="Enter your note: "
        if defined notes (
            set "notes=!notes!;!newNote!"
        ) else (
            set "notes=!newNote!"
        )
        cls
        echo Note added!
        timeout /t 1 >nul
        goto devModeLoop
    ) else if "!noteChoice!"=="2" (
        if not defined notes (
            echo No notes to delete!
            timeout /t 1 >nul
            goto devModeLoop
        )
        setlocal enabledelayedexpansion
        set i=1
        for %%N in (!notes!) do (
            echo !i!. %%N
            set /a i+=1
        )
        endlocal
        set /p delNote=Enter note number to delete: 
        setlocal enabledelayedexpansion
        set newNotes=
        set i=1
        for %%N in (!notes!) do (
            if not "!i!"=="!delNote!" (
                if defined newNotes (
                    set "newNotes=!newNotes!;%%N"
                ) else (
                    set "newNotes=%%N"
                )
            )
            set /a i+=1
        )
        endlocal
        set "notes=!newNotes!"
        cls
        echo Note deleted!
        timeout /t 1 >nul
        goto devModeLoop
    ) else (
        goto devModeLoop
    )
) else if /i "!dev!"=="settings" (
    cls
    echo =========================
    echo       Dev Mode Settings
    echo =========================
    echo 1. Change Username
    echo 2. Change Dev Mode Password
    echo 3. Back to Dev Mode
    set /p settingChoice="Choose an option: "
    if "!settingChoice!"=="1" (
        set /p newUsername="Enter new username: "
        set "username=!newUsername!"
        echo Username changed to !username!"
        timeout /t 1 >nul
    ) else if "!settingChoice!"=="2" (
        set /p newDevPass="Enter new Dev Mode password: "
        set "devModePassword=!newDevPass!"
        echo Dev Mode password changed!
        timeout /t 1 >nul
    ) else if "!settingChoice!"=="3" (
        goto devModeLoop
    ) else (
        echo Invalid choice.
        timeout /t 2 >nul
    )
    goto devModeLoop
) else if /i "!dev!"=="log" (
    cls
    echo =========================
    echo       Dev Mode Log
    echo =========================
    echo This is a log of all dev mode commands.
    echo - Dev Mode enabled by !username! (User ID: !userID!)
    echo - Last command: !dev!
    echo.
    pause
    goto devModeLoop
) else (
    echo Invalid command. Type "help" for commands or "exit" to return.
    timeout /t 2 >nul
    goto devModeLoop
)

:end
echo Exiting Explorer...
timeout /t 1 >nul
call "NeoByteOS.bat"
exit
