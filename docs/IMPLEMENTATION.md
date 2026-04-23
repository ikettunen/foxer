# Foxer Paragliding App - Current Implementation

## Overview

Foxer is a Flutter-based paragliding training app with built-in integration tests and screenshot automation.

**Last Updated**: April 23, 2026  
**Flutter Version**: 3.x  
**Build Status**: ✅ Passes integration tests on Chrome

## App Structure

### Screens

| Screen | File | Purpose | Status |
|--------|------|---------|--------|
| **Splash** | `lib/screens/splash_screen.dart` | App startup, logo, loading | ✅ Working |
| **Login** | `lib/screens/login_screen.dart` | Email/password auth | ✅ Static form |
| **Home** | `lib/screens/home_screen.dart` | Tab-based navigation hub | ✅ Working |
| **Flight Sites** | `lib/screens/map_screen.dart` | Google Maps integration | ✅ Displays map |
| **Lessons** | `lib/screens/lessons_screen.dart` | Training content (generic) | 🔶 Placeholder |
| **Reading** | `lib/screens/reading_materials_screen.dart` | Educational content | 🔶 Placeholder |
| **Discussions** | `lib/screens/discussions_screen.dart` | Community chat | 🔶 Placeholder |

### Key Features Implemented

✅ **Authentication**
- Email/password login form
- LocalStorage persistence (SharedPreferences)
- Auto-login on app restart
- No backend (demo/local only)

✅ **Navigation**
- Bottom tab bar with 4 main sections
- Proper state management
- Smooth transitions

✅ **Maps Integration**
- Google Maps embedded
- API key configured (secure in Android/Web)
- Displays paragliding sites

✅ **Styling**
- Material Design 3
- Dark theme (black/white/grey)
- Responsive layout

### Screens Content (Current Placeholders)

#### Lessons Screen
```dart
// Currently just displays static text:
// "Lessons coming soon"
// Ready to replace with P1-P2 curriculum
```

#### Reading Materials
```dart
// Static placeholder
// Ready for TRAINING_CONTENT.md integration
```

#### Discussions
```dart
// Static placeholder
// WhatsApp linked in docs/COMMUNICATIONS.md
```

## Testing Infrastructure

### Test Files

| File | Purpose | Tests |
|------|---------|-------|
| `integration_test/app_test.dart` | Main E2E tests | Login, Navigation, Persistence |
| `integration_test/helpers.dart` | Test utilities | Wait, tap, assert helpers |
| `test_driver/integration_test.dart` | Driver for screenshots | Captures and saves images |
| `.github/workflows/integration_tests.yml` | CI automation | Runs on Chrome, uploads results |

### Test Coverage

```
✅ Login Flow
   └─ Splash → Login form → Enter credentials → Home

✅ Navigation  
   └─ All 4 tabs (Maps, Lessons, Reading, Discussions)

✅ Login Persistence
   └─ Auto-login with saved credentials
```

### Screenshots Generated

Tests automatically capture:
- `01_splash_screen.png` - App startup
- `02_login_screen.png` - Login form
- `03_login_form_filled.png` - After entering credentials
- `04_home_flight_sites.png` - Home after login
- `05-09_nav_*.png` - Navigation between tabs

## Running Tests Locally

### Windows
```bash
run_tests.bat
```

### macOS/Linux
```bash
bash run_tests.sh
```

### Manual
```bash
flutter test integration_test/ -v
```

## GitHub Actions CI/CD

### Workflow: `.github/workflows/integration_tests.yml`

**Triggers**: Push to `main`/`develop`, PR to `main`/`develop`

**Steps**:
1. Checkout code
2. Setup Flutter 3.x
3. Get dependencies
4. Run integration tests on Chrome
5. Upload test results as artifacts

**Artifacts**: 
- Test logs
- Screenshots (if captured)
- Build artifacts

## Dependencies

```yaml
dependencies:
  flutter: sdk
  google_maps_flutter: ^2.5.0  # Maps integration
  shared_preferences: ^2.2.2   # Local storage

dev_dependencies:
  flutter_test: sdk
  flutter_lints: ^3.0.0
  integration_test: sdk        # E2E testing
```

## Configuration Files

### Android
- `android/app/src/main/AndroidManifest.xml` - Google Maps API key
- `android/local.properties` - SDK path (not in repo)
- `android/build.gradle` - Dependencies

### iOS
- `ios/Runner/Info.plist` - App metadata
- `ios/Podfile` - Dependencies
- Needs Google Maps setup

### Web
- `web/index.html` - Google Maps API key in script tag
- Flutter web compatible

## Build & Run

### Debug APK (Android)
```bash
flutter build apk --debug
```

### iOS
```bash
flutter build ios --debug
```

### Web
```bash
flutter build web
flutter run -d chrome
```

### Tests
```bash
flutter test integration_test/ --platform=chrome
```

## Next Steps (Phase 1)

- [ ] Update map default to Finland (Ylläs/Himos)
- [ ] Replace Lessons with P1-P2 curriculum
- [ ] Add 5-point pre-flight checklist to home
- [ ] Link Reading Materials to TRAINING_CONTENT.md

## Next Steps (Phase 2)

- [ ] Weather API integration (OpenWeatherMap)
- [ ] Fly/no-fly recommendation engine
- [ ] Persistent checklist history
- [ ] Full P1-P5 curriculum

## File Locations

```
foxer/
├── lib/
│   ├── main.dart                    # App entry point
│   └── screens/
│       ├── splash_screen.dart
│       ├── login_screen.dart
│       ├── home_screen.dart
│       ├── map_screen.dart
│       ├── lessons_screen.dart
│       ├── reading_materials_screen.dart
│       └── discussions_screen.dart
├── integration_test/
│   ├── app_test.dart               # Main tests
│   ├── helpers.dart                # Test utilities
│   └── README.md
├── test_driver/
│   └── integration_test.dart       # Screenshot driver
├── .github/
│   ├── workflows/
│   │   └── integration_tests.yml   # CI automation
│   └── ISSUE_TEMPLATE/
│       ├── bug_report.md
│       └── feature_request.md
├── docs/
│   ├── COMMUNICATIONS.md           # WhatsApp + team info
│   ├── SETUP.md                    # Developer setup
│   ├── TRAINING_CONTENT.md         # Curriculum data
│   └── IMPLEMENTATION.md           # (This file)
├── pubspec.yaml                    # Dependencies
└── README.md
```

## API Keys & Secrets

🔐 **Google Maps API Key**: `AIzaSyANeXz8Z_1ukadMZfTYfhfKVPzuAWF6TzA`
- Added to: `web/index.html`, `android/app/src/main/AndroidManifest.xml`
- Needs API restrictions in Google Cloud Console
- **DO NOT commit with real key in production** (already in `.gitignore`)

## Git Workflow

```bash
# Feature branch
git checkout -b feature/feature-name

# Make changes
# Run tests
flutter test integration_test/

# Commit
git commit -m "feat: description"

# Push (triggers CI)
git push origin feature/feature-name

# Create PR
# CI automatically runs tests on Chrome
# Review + merge
```

## Performance Notes

- Login form validation is instant (client-side)
- Map rendering is async (no blocking)
- Test suite runs in ~30-60 seconds on Chrome
- Integration tests use Chrome driver (no emulator needed)

## Known Limitations

- 🔶 No backend API (static auth)
- 🔶 Map has dummy pins (not real sites)
- 🔶 Lessons/Reading/Discussions are placeholders
- 🔶 No PWA features yet (web)
- 🔶 Logout not implemented

## Quick Reference

| Task | Command |
|------|---------|
| Run app | `flutter run` |
| Run tests | `flutter test integration_test/` |
| Build APK | `flutter build apk` |
| Check analysis | `flutter analyze` |
| Format code | `flutter format .` |
| Get dependencies | `flutter pub get` |
| Clean build | `flutter clean` |

---

**Status**: MVP with solid testing infrastructure ready for content integration.
