# Integration Tests

Automated end-to-end tests for the Paragliding Training app covering login, navigation, and persistence.

**Also see**: [Screenshots & CI/CD Guide](../docs/SCREENSHOTS_CI.md) | [App Implementation Status](../docs/IMPLEMENTATION.md)

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
flutter test integration_test/app_test.dart -v --platform=chrome
```

## What's Tested

| Test | Coverage | Time |
|------|----------|------|
| **Login Flow** | Splash screen → login form → successful login & navigation | ~15s |
| **Navigation** | All 4 app tabs (Flight Sites, Lessons, Reading, Discussions) | ~10s |
| **Persistence** | Auto-login on app restart with saved credentials | ~10s |

## Screenshots

Tests capture screenshots at each step. See [SCREENSHOTS_CI.md](../docs/SCREENSHOTS_CI.md) for:
- Screenshot locations
- GitHub Actions setup  
- Downloading results
- Troubleshooting

## Test Structure

- `app_test.dart` - Main test suite (3 tests)
- `helpers.dart` - Reusable test utilities
- `.github/workflows/integration_tests.yml` - CI/CD automation

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

Tests run automatically on:
- ✅ Every push to `main` or `develop`
- ✅ Every pull request
- ✅ Manual trigger via GitHub Actions

Results uploaded as artifacts. PRs get automatic comment with download link.

## Notes

- Screenshots use `convertFlutterSurfaceToImage()` for actual capture
- Tests run on Chrome (no emulator needed)
- Uses modern Flutter APIs (no deprecated code)
- Demo login: any email/password combination works

## Notes

- Logout test is pending: implement logout in the app first
- Screenshots use `convertFlutterSurfaceToImage()` for actual capture
- Uses modern Flutter APIs (no deprecated `physicalSizeTestValue`)
- Timing uses `pumpAndSettle()` instead of hardcoded delays
