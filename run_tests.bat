@echo off
REM Script to run integration tests locally on Windows with screenshots

echo.
echo 🧪 Paragliding Training App - Integration Tests
echo ================================================
echo.

REM Check if Flutter is installed
flutter --version
if %errorlevel% neq 0 (
    echo ❌ Flutter is not installed or not in PATH
    exit /b 1
)

echo ✅ Flutter found
echo.

REM Get dependencies
echo 📦 Getting dependencies...
call flutter pub get

echo.
echo 🏃 Running integration tests...
echo 📸 Screenshots will be captured during test execution
echo.

REM Run tests with verbose output
call flutter test integration_test/app_test.dart ^
    --no-pub ^
    --verbose ^
    --platform=chrome

echo.
echo ✅ Test run completed!
echo.
echo 📸 Screenshots captured:
echo   Check console output above for screenshot timing
echo   Build artifacts: build\
echo.

REM Optional: Open build directory
echo 📁 Opening build directory...
start build
pause
