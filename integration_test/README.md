# Integration Tests

This directory contains end-to-end integration tests for the Paragliding Training app.

## Setup

Tests are already configured in `pubspec.yaml`. To run them, you'll need an Android emulator or physical device.

## Running Tests

### All Integration Tests
```bash
flutter test integration_test/app_test.dart
```

### With Screenshots (Android)
```bash
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart
```

To capture screenshots on Android, make sure screenshots are enabled and they'll be saved to a results directory.

### On Android Emulator
```bash
# Start emulator first
emulator -avd Pixel_6_API_30

# Run tests
flutter test integration_test/ -v
```

### On iOS Simulator
```bash
# Start simulator
open -a Simulator

# Run tests
flutter test integration_test/ -v
```

### On Physical Device
1. Connect device via USB
2. Enable Developer Mode (Android) or Trust Computer (iOS)
3. Run tests:
```bash
flutter test integration_test/ -v
```

## Test Coverage

The test suite includes:

### 1. **Login Flow Test** (`test_01_login`)
- Tests app startup with splash screen
- Validates login form UI
- Enters email and password credentials
- Verifies successful login and navigation to home screen
- Screenshots: Splash screen → Login form → Login filled → Home screen

### 2. **Navigation Test** (`test_02_navigation`)
- Tests navigation between all app sections
- Validates tab switching works correctly
- Tests all 4 navigation tabs:
  - Flight Sites (Maps)
  - Lessons
  - Reading Materials
  - Discussions
- Screenshots: Each tab navigation step

### 3. **Login Persistence Test** (`test_03_persistence`)
- Verifies login state is remembered
- Tests app restart with saved credentials
- Validates auto-navigation to home screen when already logged in

### 4. **Logout Flow Test** (`test_04_logout`)
- Tests logout functionality (if implemented)
- Currently checks for menu button and logout option
- Verifies return to login screen after logout

## Screenshot Locations

Screenshots are captured during test execution and saved to:
- **Android**: `build/android/screenshots/`
- **iOS**: `build/ios/screenshots/`
- **Web**: `build/web/screenshots/`

Screenshot naming convention:
- `01_splash_screen` - Initial splash screen
- `02_login_screen` - Login form before input
- `03_login_form_filled` - Login form with credentials entered
- `04_home_flight_sites` - Home screen after login
- `05_nav_*` - Navigation test screenshots
- `10_login_persisted` - Login persistence verification
- `11_logout_success` - After logout

## Test Helpers

Helper functions in `helpers.dart`:

- `waitForWidget(tester, key)` - Wait for a widget to appear
- `tapByKey(tester, key)` - Tap a widget by key
- `tapByText(tester, text)` - Tap a widget by text
- `enterText(tester, key, text)` - Enter text into a field
- `takeScreenshot(tester, name)` - Capture a screenshot
- `waitForText(tester, text)` - Wait for text to appear
- `scrollAndTap(tester, text)` - Scroll list and tap item
- `expectText(text)` - Assert text is visible
- `expectKey(key)` - Assert widget by key is visible

## Debugging Tests

### Verbose Output
```bash
flutter test integration_test/app_test.dart -v
```

### Run Single Test
```bash
flutter test integration_test/app_test.dart -k "login flow test"
```

### Enable Screenshots with Driver
Create `test_driver/integration_test.dart`:
```dart
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() => integrationDriver();
```

Then run:
```bash
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart
```

## CI/CD Integration

To integrate tests into CI/CD pipeline:

### GitHub Actions Example
```yaml
- name: Run Integration Tests
  run: |
    flutter test integration_test/ -v
```

### Pre-commit Hook
Add to `.git/hooks/pre-commit`:
```bash
#!/bin/bash
flutter test integration_test/ --fail-on-error
```

## Common Issues

### Tests timing out
- Increase timeouts in helper functions
- Ensure device/emulator is responsive
- Check for network issues

### Screenshots not being captured
- Some devices require `.screenshots()` to be called with proper configuration
- Add `--screenshots` flag when running with driver

### App crashes during test
- Check logs: `flutter logs`
- Verify test data (email, password) is valid
- Ensure MockData is properly set up

##Continuous Improvements

- [ ] Add performance tests
- [ ] Add test coverage reporting
- [ ] Add visual regression testing
- [ ] Add test result reporting to GitHub
- [ ] Add E2E tests for error scenarios
- [ ] Add API integration tests

## References

- [Flutter Integration Testing](https://flutter.dev/docs/testing/integration-tests)
- [Flutter Driver](https://flutter.dev/docs/testing/integration-tests)
- [Integration Test Package](https://pub.dev/packages/integration_test)
