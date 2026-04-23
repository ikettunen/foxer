@echo off
REM Simple screenshot batch script for Foxer Paragliding app
REM Requires: Windows 10+ (has built-in screenshot utility)
REM 
REM Usage: Run this file and follow prompts
REM Screenshots will be saved with timestamp

setlocal enabledelayedexpansion

echo.
echo ====================================
echo Foxer Paragliding - Screenshot Tool
echo ====================================
echo.

REM Check if PowerShell is available
where powershell >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: PowerShell not found
    echo Please use: Windows + Shift + S for manual screenshots
    pause
    exit /b 1
)

echo 📸 Instructions:
echo.
echo 1. Make sure the Flutter app is running:
echo    flutter run -d chrome
echo.
echo 2. Keep the Chrome window visible and in focus
echo.
echo 3. Click any key to start capturing (max 3 screenshots)
echo.
pause

REM Create screenshots directory if needed
if not exist "%~dp0" mkdir "%~dp0"

REM Get timestamp
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c%%a%%b)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
set timestamp=%mydate%_%mytime%

REM Use PowerShell to take screenshot
echo.
echo 📸 Capturing screenshot 1 of 3: Splash/Home Screen
echo(
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('%PrintScreen%'); Start-Sleep -Milliseconds 500"

REM Save from clipboard using PowerShell
powershell -Command "[System.Windows.Forms.Screen]::PrimaryScreen | ForEach-Object { $bitmap = New-Object System.Drawing.Bitmap($_.Bounds.Width, $_.Bounds.Height); [System.Drawing.Graphics]::FromImage($bitmap).CopyFromScreen($_.Bounds.Location, [System.Drawing.Point]::Empty, $_.Bounds.Size); $bitmap.Save('%~dp0..\screenshots\01_splash_%timestamp%.png'); $bitmap.Dispose() }" 2>nul

if %errorlevel% equ 0 (
    echo ✅ Screenshot 1 saved
) else (
    echo ⚠️  Screenshot 1 may not have captured (clipboard method failed)
    echo    Use Windows + Shift + S for manual capture instead
)

echo.
echo 📸 Now navigate to a different screen in the app...
echo.
timeout /t 3

echo 📸 Capturing screenshot 2 of 3: Second Screen
powershell -Command "[System.Windows.Forms.Screen]::PrimaryScreen | ForEach-Object { $bitmap = New-Object System.Drawing.Bitmap($_.Bounds.Width, $_.Bounds.Height); [System.Drawing.Graphics]::FromImage($bitmap).CopyFromScreen($_.Bounds.Location, [System.Drawing.Point]::Empty, $_.Bounds.Size); $bitmap.Save('%~dp0..\screenshots\02_screen_%timestamp%.png'); $bitmap.Dispose() }" 2>nul

if %errorlevel% equ 0 (
    echo ✅ Screenshot 2 saved
)

echo.
echo 📸 Navigate to another screen...
echo.
timeout /t 3

echo 📸 Capturing screenshot 3 of 3: Third Screen  
powershell -Command "[System.Windows.Forms.Screen]::PrimaryScreen | ForEach-Object { $bitmap = New-Object System.Drawing.Bitmap($_.Bounds.Width, $_.Bounds.Height); [System.Drawing.Graphics]::FromImage($bitmap).CopyFromScreen($_.Bounds.Location, [System.Drawing.Point]::Empty, $_.Bounds.Size); $bitmap.Save('%~dp0..\screenshots\03_screen_%timestamp%.png'); $bitmap.Dispose() }" 2>nul

if %errorlevel% equ 0 (
    echo ✅ Screenshot 3 saved
)

echo.
echo ====================================
echo ✅ Screenshot capture complete!
echo ====================================
echo.
echo Saved to: %~dp0..\screenshots\
echo.
echo 💡 Tip: Use Windows + Shift + S for manual screenshots anytime
echo.
pause
