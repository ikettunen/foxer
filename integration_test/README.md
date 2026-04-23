# Integration Tests

Automated end-to-end tests for the Paragliding Training app covering login, navigation, and persistence.

## Quick Start

### Windows
```bash
run_tests.bat
```

### macOS/Linux
```bash
bash run_tests.sh
```

### Manual Run
```bash
flutter test integration_test/ -v
```

## What's Tested

| Test | Coverage |
|------|----------|
| **Login Flow** | Splash screen → login form → successful login & navigation |
| **Navigation** | All 4 app tabs (Flight Sites, Lessons, Reading, Discussions) |
| **Persistence** | Auto-login on app restart with saved credentials |

## Test Structure

- `app_test.dart` - Main test suite
- `helpers.dart` - Reusable test utilities
- `.github/workflows/integration_tests.yml` - CI/CD automation (runs on Chrome)

## Helpers

```dart
await waitForWidget(tester, key);          // Wait for widget
await tapByKey(tester, key);               // Tap widget
await enterText(tester, key, 'text');      // Type text
await takeScreenshot(tester, 'name');      // Capture screenshot
await waitForText(tester, 'text');         // Wait for text
expectText('text');                        // Assert text visible
```

## CI/CD

Tests run automatically on every push/PR to `main` or `develop` via GitHub Actions on Chrome. Artifacts uploaded after each run.

## Notes

- Logout test is pending: implement logout in the app first
- Screenshots use `convertFlutterSurfaceToImage()` for actual capture
- Uses modern Flutter APIs (no deprecated `physicalSizeTestValue`)
- Timing uses `pumpAndSettle()` instead of hardcoded delays
