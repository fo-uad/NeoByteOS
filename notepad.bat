@echo off
title Simple Notepad
:menu
cls
echo =========================
echo       Simple Notepad
echo =========================
echo.
echo 1. Create New File
echo 2. Open Existing File
echo 3. Exit
echo.
set /p choice=Choose an option (1-3): 

if "%choice%"=="1" goto newfile
if "%choice%"=="2" goto openfile
if "%choice%"=="3" call "NeoByteOS.bat"
echo Invalid choice. Press any key to try again...
pause >nul
goto menu

:newfile
cls
set /p filename=Enter file name (with .txt): 
if exist "%filename%" (
    echo File already exists. Press any key to overwrite...
    pause >nul
)
echo Enter your text. Type "SAVE" on a new line to save and return to the menu.
:typing
set /p line=
if /i "%line%"=="SAVE" goto menu
echo %line%>>"%filename%"
goto typing

:openfile
cls
set /p filename=Enter file name to open (with .txt): 
if not exist "%filename%" (
    echo File does not exist. Press any key to return to menu...
    pause >nul
    goto menu
)
cls
echo =========================
echo Viewing %filename%
echo =========================
type "%filename%"
echo.
echo =========================
echo Press any key to return to menu...
pause >nul
goto menu
