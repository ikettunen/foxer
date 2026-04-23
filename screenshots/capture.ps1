# Foxer Paragliding - Screenshot Capture Script
# 
# Usage: powershell -ExecutionPolicy Bypass -File screenshots/capture.ps1
# Or run: .\screenshots\capture.ps1
#
# Prerequisites: Windows with built-in screenshot capability
# The app must be running: flutter run -d chrome

Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Foxer Paragliding - Screenshot Tool" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Check if Chrome is running
$chromeProcess = Get-Process chrome -ErrorAction SilentlyContinue
if (-not $chromeProcess) {
    Write-Host "⚠️  Chrome not detected" -ForegroundColor Yellow
    Write-Host "Make sure the app is running: flutter run -d chrome" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to continue anyway"
}

# Get timestamp
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$screenshotsPath = Split-Path -Parent $PSCommandPath

Write-Host "📸 Screenshot Helper" -ForegroundColor Green
Write-Host ""
Write-Host "Instructions:" -ForegroundColor Green
Write-Host "1. Position the Chrome window with the app running"
Write-Host "2. This tool will guide you through capturing screenshots"
Write-Host "3. Screenshots will be saved with timestamps"
Write-Host ""

# Function to take screenshot using .NET
function Copy-ScreenToFile {
    param($FilePath)
    
    try {
        [Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null
        
        $screen = [System.Windows.Forms.Screen]::PrimaryScreen
        $bitmap = New-Object System.Drawing.Bitmap($screen.Bounds.Width, $screen.Bounds.Height)
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $graphics.CopyFromScreen($screen.Bounds.Location, [System.Drawing.Point]::Empty, $screen.Bounds.Size)
        $bitmap.Save($FilePath)
        $graphics.Dispose()
        $bitmap.Dispose()
        return $true
    }
    catch {
        return $false
    }
}

# Screenshot 1: Splash/Home
Write-Host "Step 1: Capture the Splash or Home screen" -ForegroundColor Green
Write-Host "  • Make sure the app window is visible"
Write-Host "  • Press Enter to capture"
Read-Host

$file1 = Join-Path $screenshotsPath "01_splash_$timestamp.png"
if (Copy-ScreenToFile $file1) {
    Write-Host "✅ Screenshot 1 saved: 01_splash_$timestamp.png" -ForegroundColor Green
} else {
    Write-Host "⚠️  Could not save screenshot (using alternative method)" -ForegroundColor Yellow
    Write-Host "  Use Windows + Shift + S for manual capture" -ForegroundColor Yellow
}

# Screenshot 2: Any screen
Write-Host ""
Write-Host "Step 2: Navigate to another screen and capture" -ForegroundColor Green
Write-Host "  • Click buttons in the app to navigate"
Write-Host "  • Take another screenshot (press Windows + Shift + S manually, OR press Enter here)"
Read-Host

$file2 = Join-Path $screenshotsPath "02_screen_$timestamp.png"
if (Copy-ScreenToFile $file2) {
    Write-Host "✅ Screenshot 2 saved: 02_screen_$timestamp.png" -ForegroundColor Green
} else {
    Write-Host "⚠️  Could not save screenshot (using alternative method)" -ForegroundColor Yellow
}

# Screenshot 3: Another screen
Write-Host ""
Write-Host "Step 3: Navigate to another screen and capture" -ForegroundColor Green
Write-Host "  • Press Enter to capture 3rd screenshot"
Read-Host

$file3 = Join-Path $screenshotsPath "03_screen_$timestamp.png"
if (Copy-ScreenToFile $file3) {
    Write-Host "✅ Screenshot 3 saved: 03_screen_$timestamp.png" -ForegroundColor Green
} else {
    Write-Host "⚠️  Could not save screenshot (using alternative method)" -ForegroundColor Yellow
}

# Summary
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "✅ Screenshot capture complete!" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Saved location: $screenshotsPath" -ForegroundColor Green
Write-Host ""
Write-Host "💡 Alternative methods:" -ForegroundColor Yellow
Write-Host "  • Windows + Shift + S: Built-in Snip & Sketch"
Write-Host "  • F12 in Chrome: DevTools screenshot option"
Write-Host "  • Print Screen: Full screen capture to clipboard"
Write-Host ""
Write-Host "🎬 App is still running. Check the Chrome window:" -ForegroundColor Green
Write-Host "  • All 7 screens should be accessible"
Write-Host "  • Login then browse: Home → Lessons → Reading → Discussions"
Write-Host ""

# Show captured files
$files = Get-ChildItem $screenshotsPath -Filter "*_$timestamp.png" -ErrorAction SilentlyContinue
if ($files) {
    Write-Host "Captured files:" -ForegroundColor Green
    foreach ($file in $files) {
        Write-Host "  • $($file.Name)" -ForegroundColor Green
    }
}

Write-Host ""
Read-Host "Press Enter to exit"
