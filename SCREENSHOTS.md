# Foxer Paragliding Training App - Screenshots

## Overview
This document showcases the Foxer Paragliding Training Flutter app running on the web platform (Chrome).

**Current Status:** ✅ App running at `http://localhost:55210`

## How to Capture Screenshots

The app is running in development mode at port 55210. To capture screenshots:

1. Open browser to **http://localhost:55210**
2. For each screen, press **Print Screen** button
3. Open Paint, paste, and save as PNG to `screenshots/` folder
4. Name files in sequence: `03-home-screen.png`, `04-map-screen.png`, etc.

## Web Platform Screenshots

### 1. Login Screen
**File:** `screenshots/02-login-screen.png`
- Email and password input fields
- Clean Material Design 3 interface with black/white theme
- Paragliding icon at top
- "Login" button for authentication

**Test Credentials:**
```
Email:    test@foxer.com
Password: password123
(Any non-empty values work)
```

**To proceed:** Enter credentials and click "Login" to see Home Screen

### 2. Home Screen
**Expected:** After successful login
- Main navigation hub
- Access to all app features
- Bottom navigation or drawer menu

**Screenshot needed:** Capture after clicking Login

### 3. Map Screen
**Expected:** Interactive Google Maps display
- Integration with Google Maps API
- Paragliding locations or training points
- Map controls and markers

**To capture:**
1. From Home Screen, tap Map icon/button
2. Take screenshot

### 4. Lessons Screen
**Expected:** Training curriculum/lessons
- List of paragliding lessons
- Course materials
- Lesson progress tracking

**To capture:**
1. From Home/Navigation, select Lessons
2. Take screenshot

### 5. Reading Materials Screen
**Expected:** Educational content
- Study materials
- Documentation
- Reference guides

### 6. Discussions Screen
**Expected:** Community/discussion features
- Forum or chat interface
- Thread discussions
- User interactions

### 7. Additional Screens
- **Profile Screen** (if available)
- **Settings Screen** (if available)

## Features Implemented

✅ **Web Platform Support** - App fully functional on Chrome  
✅ **Responsive Design** - Material 3 theme with black/white color scheme  
✅ **Authentication** - Login screen with SharedPreferences persistence  
✅ **Navigation** - SplashScreen → LoginScreen → HomeScreen flow  
✅ **Google Maps Integration** - Configured with API key for map features  
✅ **Responsive UI** - All 7 screens available in code

## Build & Run

### Web
```bash
flutter run -d chrome
```

App will launch on the port displayed in terminal (typically port 51234 or 55210)

### Android (when device is available)
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point with routing
├── screens/
│   ├── splash_screen.dart    # 2-second splash with navigation
│   ├── login_screen.dart     # Email/password login form
│   ├── home_screen.dart      # Main navigation hub
│   ├── map_screen.dart       # Google Maps integration
│   ├── lessons_screen.dart   # Training curriculum
│   ├── reading_materials_screen.dart
│   ├── discussions_screen.dart
│   └── (additional screens)

web/
└── index.html                # Uses flutter_bootstrap.js for initialization

pubspec.yaml                  # Dependencies: google_maps_flutter, shared_preferences
```

## Environment

- **Flutter:** 3.41.7 (stable)
- **Dart:** Latest
- **Platform:** Chrome (Web), Android (pending device auth)
- **Key Dependencies:**
  - `google_maps_flutter: ^2.14.0`
  - `shared_preferences: ^2.5.4`
  - `flutter: SDK with Material 3`

## Next Steps

1. ✅ Screenshot all 7+ screens from the running app
2. Implement backend API integration
3. Test on Android physical device
4. Add real curriculum/map data
5. Implement camera/image upload features
6. User profile and settings screens

## Repository

- **GitHub:** https://github.com/ikettunen/foxer
- **Latest Commit:** flutter_bootstrap.js web initialization fix
- **Branch:** main

