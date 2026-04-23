# Screenshots & CI/CD Guide

Automated screenshot capture for the Foxer app via GitHub Actions and local testing.

## How It Works

The test suite automatically captures screenshots at key moments:
- After splash screen loads
- Login form (empty and filled)
- After successful login (home screen)
- While navigating between tabs

Screenshots are captured using Flutter's `convertFlutterSurfaceToImage()` during test execution.

## Running Tests Locally to Get Screenshots

### Windows
```bash
run_tests.bat
```

### macOS/Linux
```bash
bash run_tests.sh
```

### Manual (Any Platform)
```bash
flutter test integration_test/app_test.dart -v --platform=chrome
```

**Output**: Look for `📸 Screenshot captured:` messages in console output.

## GitHub Actions Workflow

### What Runs

Every push to `main`/`develop` and every PR automatically:

1. ✅ Checks out your code
2. ✅ Installs Flutter
3. ✅ Gets dependencies
4. ✅ Runs integration tests on Chrome
5. ✅ Captures screenshots during test
6. ✅ Uploads test results as artifacts
7. ✅ Posts summary comment on PRs

### Accessing Results

#### On GitHub

1. **Go to Actions tab**: `github.com/ikettunen/foxer/actions`
2. **Click latest workflow run**: "Integration Tests & Screenshots"
3. **Scroll to bottom**: Find "Artifacts" section
4. **Download**: `integration-test-results` ZIP
5. **Extract**: Contains build directory with screenshots

#### On Pull Request

Each PR automatically gets a comment like:
```
✅ Integration Tests Completed

- Platform: Chrome
- Tests: Login Flow, Navigation, Login Persistence
- Status: Check artifacts for results

📊 Download Test Results
```

Click the link to download results.

### Workflow File Location

`.github/workflows/integration_tests.yml`

View live at: https://github.com/ikettunen/foxer/actions/workflows/integration_tests.yml

## Test Output Example

```
⏳ Waiting for splash screen...
📸 Screenshot captured: 01_splash_screen
✅ Verifying login form...
📝 Entering email...
📝 Entering password...
📸 Screenshot captured: 03_login_form_filled
🔐 Tapping login button...
✅ Verifying login success...
📸 Screenshot captured: 04_home_flight_sites
📍 Testing Flight Sites tab...
📸 Screenshot captured: 05_nav_flight_sites
📍 Navigating to Lessons tab...
📸 Screenshot captured: 06_nav_lessons
...
✅ All navigation tests passed!
```

## Screenshots Captured

| Screenshot | When | Purpose |
|-----------|------|---------|
| `01_splash_screen` | App startup (2s delay) | Verify logo and loading |
| `02_login_screen` | Before form input | Verify form layout |
| `03_login_form_filled` | After entering credentials | Verify data entry |
| `04_home_flight_sites` | After login redirect | Verify home navigation |
| `05_nav_flight_sites` | Map tab active | Flight Sites screen |
| `06_nav_lessons` | Lessons tab active | Lessons screen |
| `07_nav_reading_materials` | Reading tab active | Reading screen |
| `08_nav_discussions` | Discussions tab active | Discussions screen |
| `09_nav_back_to_flight_sites` | Back to first tab | Navigation works both ways |
| `10_login_persisted` | Auto-login test | Shows persistent login works |

## Troubleshooting

### Chrome Driver Issues

If tests fail with Chrome errors:

1. **Check Chrome is installed**:
   ```bash
   google-chrome --version
   ```

2. **Clear cache**:
   ```bash
   flutter clean
   flutter pub get
   ```

3. **Run with manual platform**:
   ```bash
   flutter test integration_test/ -v --platform=chrome
   ```

### Screenshots Not Appearing

If you see `🧪 Test run completed!` but no screenshots:

1. **Verify test ran**: Look for `✅` marks in output
2. **Check for errors**: Search console for `⚠️ Screenshot failed`
3. **Verify paths**: Check `build/` directory exists
4. **Run verbose**: Add `-v` flag for detailed output

### CI Tests Fail Locally

If tests pass locally but fail in GitHub Actions:

1. Check Flutter version matches in `.github/workflows/integration_tests.yml`
2. Verify all dependencies are in `pubspec.yaml`
3. Look for timezone/locale issues in test
4. Check for file system permission issues

## Tips

### Run Only Specific Test
```bash
flutter test integration_test/app_test.dart -k "login flow test" -v
```

### Run with Real Device
```bash
flutter test integration_test/ -v -d <device_id>
```

### Generate HTML Report (Linux/Mac)
```bash
flutter test integration_test/ --reporter=json > report.json
# Then parse JSON for custom reports
```

### Keep Chrome Open After Test
```bash
flutter test integration_test/ --verbose --no-headless
```

## Environment Variables

No special env vars needed, but for future API integration:

```bash
# These can be passed to GitHub Actions secret
GOOGLE_MAPS_API_KEY=...
WEATHER_API_KEY=...
```

## Next Steps

- [ ] Add visual regression testing (compare screenshots)
- [ ] Add performance metrics to screenshots
- [ ] Generate PDF report from screenshots
- [ ] Slack notifications on test failure
- [ ] Archive screenshots per release

## References

- [Flutter Integration Testing](https://flutter.dev/docs/testing/integration-tests)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Chrome Driver](https://chromedriver.chromium.org/)
