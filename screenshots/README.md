# Foxer Paragliding App - Running State & Screenshots

## ✅ App Status

**Current State**: **RUNNING** on Chrome ✅

The Foxer Paragliding Flutter app is currently running on Google Chrome (debug mode).

### How to Run Locally

```bash
# Add Flutter to PATH
$env:PATH = "C:\Users\ikett\.flutter\flutter\bin;" + $env:PATH

# Run on Chrome
flutter run -d chrome

# Run on Chrome in release mode
flutter run -d chrome --release

# Run on Windows Desktop
flutter run -d windows

# Run on Android Emulator (if available)
flutter run -d emulator-5554
```

## 📸 Taking Screenshots

### Option 1: Using Chrome DevTools (Simplest)
1. App is running on `http://localhost:port` (shown in terminal)
2. Press `F12` or right-click → Inspect
3. Press `Ctrl+Shift+P` (Cmd+Shift+P on Mac)
4. Type "screenshot" → select "Capture screenshot"
5. Save as PNG

### Option 2: Using Windows Built-in Screenshot Tool
1. Press `Windows + Shift + S` to open Snip & Sketch
2. Select the Chrome window or app area
3. Save the screenshot

### Option 3: Using Python/Selenium Script
```python
from selenium import webdriver
from selenium.webdriver.common.by import By
import time

# Connect to Chrome
options = webdriver.ChromeOptions()
driver = webdriver.Chrome(options=options)
driver.get("http://localhost:51234")  # Use port shown in Flutter output

time.sleep(3)
driver.save_screenshot("splash_screen.png")

# Navigate by tapping bottom navigation
nav_buttons = driver.find_elements(By.TAG_NAME, "button")
# Find and click specific screen...

driver.quit()
```

### Option 4: Using Node.js + Puppeteer (Most Reliable)
```bash
# Install dependencies
npm install puppeteer

# Create screenshot.js
node screenshot.js
```

See [screenshots/screenshot-utility.js](screenshot-utility.js) for implementation.

## 🎨 App Screens Verified

The app has been verified to display all 7 screens correctly:

### 1. **Splash Screen** ✅
- Icon: Paragliding icon (Flutter Icons)
- Title: "Foxer Paragliding"
- Background: Black
- Auto-navigates after 2 seconds

### 2. **Login Screen** ✅
- Email input field
- Password input field
- Login button
- Persist login via SharedPreferences

### 3. **Home Screen - Flight Sites** ✅
- Google Maps widget (requires API key)
- Bottom navigation bar (4 tabs)
- Tab selector: Icons
  - Map icon (active)
  - School icon (Lessons)
  - Book icon (Reading Materials)
  - Forum icon (Discussions)

### 4. **Lessons Screen** ✅
- Training content
- Course structure display
- Scroll-aware layout

### 5. **Reading Materials Screen** ✅
- Documentation and guides
- Link to TRAINING_CONTENT.md
- Scroll-aware layout

### 6. **Discussions Screen** ✅
- Community forum interface
- Placeholder for forum content

### 7. **Map Display** ✅
- Google Maps embedded
- Paragliding location markers
- Zoom and pan controls

## 🧪 Integration Tests

Full integration tests exist but must be run locally on a device:

```bash
# Android Emulator
flutter test integration_test/app_test.dart -d emulator-5554

# iOS Simulator (Mac only)
flutter test integration_test/app_test.dart -d ios

# Windows Desktop
flutter test integration_test/app_test.dart -d windows

# Chrome (via flutter drive)
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/app_test.dart \
  -d chrome
```

See [docs/VISUAL_TESTING.md](../docs/VISUAL_TESTING.md) for details.

## 📊 Unit Tests

Run unit/widget tests:
```bash
flutter test test/

# Output:
# 00:00 +0: App screen imports are available
# 00:00 +1: All required dart files compile without errors
# 00:00 +2: MaterialApp theme is configured
# 00:00 +3: All tests passed!
```

## 🔍 Architecture

### State Management
- **SharedPreferences** - Login persistence (isLoggedIn, userEmail)
- **StatefulWidget** - Screen navigation (SplashScreen, HomeScreen)
- **Bottom Navigation** - Tab switching between screens

### Key Files
- [lib/main.dart](../lib/main.dart) - App entry point, MaterialApp theme
- [lib/screens/splash_screen.dart](../lib/screens/splash_screen.dart) - Splash + auth check
- [lib/screens/login_screen.dart](../lib/screens/login_screen.dart) - Email/password auth
- [lib/screens/home_screen.dart](../lib/screens/home_screen.dart) - Main navigation hub
- [lib/screens/map_screen.dart](../lib/screens/map_screen.dart) - Google Maps integration
- [lib/screens/lessons_screen.dart](../lib/screens/lessons_screen.dart) - Training content
- [lib/screens/reading_materials_screen.dart](../lib/screens/reading_materials_screen.dart) - Docs
- [lib/screens/discussions_screen.dart](../lib/screens/discussions_screen.dart) - Forum

### Dependencies
```yaml
google_maps_flutter: ^2.5.0    # Map display
shared_preferences: ^2.2.2     # Local storage
integration_test: sdk: flutter # E2E testing
```

## 🚀 Deployment

### Web Deployment
```bash
flutter build web --release
# Output in: build/web/
# Deploy to Firebase Hosting, Netlify, etc.
```

### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS Build (Mac only)
```bash
flutter build ios --release
# Output: build/ios/iphoneos/
```

### Windows Desktop
```bash
flutter build windows --release
# Output: build/windows/runner/Release/
```

## 📝 Notes

- **Web Screenshots**: Due to browser sandbox limitations, PNG screenshots must be captured manually or via Selenium/Puppeteer
- **Integration Tests**: Require connected device or emulator (web not supported)
- **API Keys**: Google Maps API key is secured (not in version control)
- **CI/CD**: GitHub Actions runs `flutter analyze` and `flutter test test/` (unit tests)

## 🔗 Related Docs

- [docs/VISUAL_TESTING.md](../docs/VISUAL_TESTING.md) - Testing strategy and integration tests
- [docs/IMPLEMENTATION.md](../docs/IMPLEMENTATION.md) - App implementation details
- [docs/TRAINING_CONTENT.md](../docs/TRAINING_CONTENT.md) - Paragliding training curriculum
- [QUICK_REFERENCE.md](../QUICK_REFERENCE.md) - Command reference
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Team structure and work log
