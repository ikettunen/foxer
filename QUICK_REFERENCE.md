# Quick Reference: Running Tests

## ✅ Correct Commands

### Windows
```bash
run_tests.bat
```

### macOS/Linux  
```bash
bash run_tests.sh
```

### Manual (Any OS)
```bash
flutter test integration_test/app_test.dart -v --platform=chrome
```

## ❌ Common Mistakes

```bash
# WRONG - Missing --platform=chrome
flutter test integration_test/app_test.dart

# WRONG - Missing platform flag
flutter test integration_test/ -v

# WRONG - Old command without platform
flutter test integration_test/ --verbose --web-renderer=html
```

## Why --platform=chrome?

- Integration tests need a device/platform to run on
- Chrome = headless browser (works everywhere, no emulator needed)
- Without it, Flutter looks for Android/iOS devices
- CI/CD requires `--platform=chrome` for headless GitHub Actions

## What Happens

```
flutter test integration_test/app_test.dart \
  --platform=chrome  # Use Chrome browser
  --verbose          # Show all output
  -v                 # Verbose logging
```

1. Launches Chrome headlessly
2. Runs app in Chrome
3. Captures screenshots
4. Reports test results

## Exit Code 1 Fix

If you see:
```
Web devices are not supported for integration tests yet.
```

**Solution**: Add `--platform=chrome` to your command

Examples:
```bash
# Direct fix
flutter test integration_test/app_test.dart --platform=chrome

# Or use the script
run_tests.bat              # Windows
bash run_tests.sh          # macOS/Linux
```

## Full Working Commands

### CI/CD (GitHub Actions)
```bash
flutter test integration_test/app_test.dart \
  -v \
  --platform=chrome
```

### Local Development
```bash
# Windows
run_tests.bat

# macOS/Linux
bash run_tests.sh
```

### With Custom Output
```bash
flutter test integration_test/app_test.dart \
  --platform=chrome \
  --reporter=json > test_results.json
```

---

**Remember**: Always include `--platform=chrome` for integration tests!
