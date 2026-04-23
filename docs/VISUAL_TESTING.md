# Visual Testing & Integration Tests

## Overview

The Foxer Paragliding app uses integration tests to verify functionality across all screens and user flows. While traditional screenshot-based visual regression testing isn't fully supported on Chrome web platform due to browser security restrictions, we use functional verification tests to ensure UI components render correctly.

## Integration Test Structure

### Test Files
- **[integration_test/app_test.dart](../integration_test/app_test.dart)** - Main integration test suite (3 tests)
- **[integration_test/helpers.dart](../integration_test/helpers.dart)** - Reusable test utilities

### Tests Included

#### 1. Login Flow Test ✅
**File**: [integration_test/app_test.dart](../integration_test/app_test.dart#L12-L58)

Tests the complete login experience:
- ✓ Splash screen displays for 2 seconds
- ✓ Navigates to login screen automatically (if not logged in)
- ✓ Text fields are found and populated
- ✓ Login button is clickable
- ✓ Navigation to home screen after login
- ✓ "Flight Sites" tab visible after login

**Screens Verified**:
1. **Splash Screen** - Paragliding icon with "Foxer Paragliding" branding
2. **Login Screen** - Email and password input fields with submit button
3. **Home Screen** - Bottom navigation with 4 tabs

#### 2. Navigation Test ✅
**File**: [integration_test/app_test.dart](../integration_test/app_test.dart#L60-L113)

Tests all screen navigation paths:
- ✓ Pre-set login state to skip authentication
- ✓ Bottom navigation bar with 4 icons:
  - **Flight Sites** (map icon) - Shows interactive map of paragliding locations
  - **Lessons** (school icon) - Training module structure and content
  - **Reading Materials** (book icon) - Documentation and guides
  - **Discussions** (forum icon) - Community discussion board
- ✓ All tabs navigate correctly and show expected content

**Screens Verified**:
1. Flight Sites with map widget
2. Lessons with training materials
3. Reading Materials with documentation
4. Discussions with forum interface
5. Navigation back to Flight Sites

#### 3. Login Persistence Test ✅
**File**: [integration_test/app_test.dart](../integration_test/app_test.dart#L115-L135)

Tests localStorage functionality:
- ✓ SharedPreferences stores `isLoggedIn` boolean
- ✓ User email persists across app restarts
- ✓ App skips login screen if logged in previously
- ✓ Home screen shows immediately for returning users

## Visual Verification Method

Instead of PNG screenshots (limited on web), we verify:

### 1. Widget Tree Verification
```dart
// Verifies scaffold is rendered
expect(find.byType(Scaffold), findsWidgets);

// Verifies specific UI elements exist
expectText('Flight Sites');
expect(find.byIcon(Icons.map), findsOneWidget);
```

### 2. Visual Checkpoints
Each test includes `takeScreenshot(tester, 'name')` calls that:
- Wait for all animations to complete (`pumpAndSettle()`)
- Verify the Scaffold is rendered
- Log checkpoint for visual verification
- Assert no errors during rendering

### 3. Screens Tested

| Screen | Test Coverage | Widgets Verified |
|--------|---|---|
| Splash | Login Flow | Icon, Title text, Black background |
| Login | Login Flow | TextFormFields (2), ElevatedButton, White background |
| Home/Map | Navigation, Persistence | BottomNavigationBar, Map widget, All 4 tabs |
| Lessons | Navigation | Lessons title, Pricing, Course structure |
| Reading | Navigation | Reading Materials title, Documentation |
| Discussions | Navigation | Discussions title, Forum placeholder |

## Running Integration Tests

### Prerequisites
```bash
# Add Flutter bin to PATH
$env:PATH = "C:\Users\ikett\.flutter\flutter\bin;" + $env:PATH

# Get dependencies
flutter pub get
```

### Run on Chrome
```bash
# Option 1: Run directly with flutter test
flutter test integration_test/app_test.dart

# Option 2: Run with flutter drive
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d chrome
```

### Run on Windows Desktop
```bash
# First enable Windows support
flutter config --enable-windows-desktop
flutter create --platforms windows .

# Run tests
flutter test integration_test/app_test.dart -d windows
```

### Run on Android/iOS
```bash
# iOS (requires Mac)
flutter test integration_test/app_test.dart -d ios

# Android
flutter test integration_test/app_test.dart -d android
```

## Test Output Example

```
⏳ Waiting for splash screen...
📸 Taking login screen screenshot...
✅ Visual checkpoint verified: 02_login_screen
   - Scaffold found and rendered
📝 Entering email...
📝 Entering password...
📸 Taking login form filled screenshot...
✅ Visual checkpoint verified: 03_login_form_filled
   - Scaffold found and rendered
🔐 Tapping login button...
✅ Verifying login success...
📸 Home Screen - Flight Sites
✅ Visual checkpoint verified: 04_home_flight_sites
   - Scaffold found and rendered
```

## Known Limitations

### Web/Chrome Platform
- ❌ Direct image file saving not available (browser sandbox)
- ❌ PNG Screenshots must use platform-specific workarounds
- ✅ Widget rendering verification works
- ✅ User interaction testing works
- ✅ Navigation testing works

### Solution
For actual PNG screenshots in CI/CD, use:
1. **Android/iOS Emulators** - Full screenshot support
2. **Windows Desktop** - Native screenshot capability  
3. **Golden File Tests** - Visual regression via `flutter test`

## Helper Functions

### `takeScreenshot(tester, name)`
Visual checkpoint that verifies rendering without file I/O.
```dart
await takeScreenshot(tester, '01_splash_screen');
```

### `expectText(text)`
Verifies text is visible on screen.
```dart
expectText('Foxer Paragliding');
```

### `expectKey(key)`
Verifies widget with key is visible.
```dart
expectKey(const Key('login_button'));
```

### `waitForText(tester, text)`
Waits up to 5 seconds for text to appear.
```dart
await waitForText(tester, 'Flight Sites');
```

### `scrollAndTap(tester, text)`
Scrolls to find text and taps it.
```dart
await scrollAndTap(tester, 'PP1 Training');
```

## CI/CD Integration

The GitHub Actions workflow runs integration tests:
- ✅ On every push to main branch
- ✅ Tests Chrome web platform
- ✅ Uploads test logs as artifacts
- ✅ Reports pass/fail status

See [.github/workflows/integration_tests.yml](../.github/workflows/integration_tests.yml)

## Future Enhancements

1. **Golden File Tests** - Visual regression with `flutter test`
2. **Android Emulator CI** - Screenshot support on CI/CD
3. **Custom Screenshot Library** - Platform channels for web PNG capture
4. **Visual Testing Dashboard** - Historical comparison of test runs
5. **Performance Testing** - Frame rate and animation smoothness metrics

## Debugging Failed Tests

If a test fails:

```bash
# Run with verbose output
flutter test integration_test/app_test.dart -v

# Run specific test only
flutter test integration_test/app_test.dart --name "Login flow test"

# Keep device running for inspection
flutter test integration_test/app_test.dart --keep-app-running
```

## References

- [Flutter Integration Test Documentation](https://flutter.dev/docs/testing/integration-tests)
- [Flutter Test Widget Documentation](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)
- [Integration Test Package](https://pub.dev/packages/integration_test)
