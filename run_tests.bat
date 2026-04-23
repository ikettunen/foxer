@echo off
REM Script to run integration tests locally on Windows

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
echo.

REM Run tests with verbose output
call flutter test integration_test/ ^
    --no-pub ^
    --verbose

echo.
echo ✅ Test run completed!
echo.
echo Screenshots location:
echo   Android: build\android\screenshots\
echo   iOS: build\ios\screenshots\
echo   Web: build\web\screenshots\
echo.
pause
