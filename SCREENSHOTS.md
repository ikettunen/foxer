# Foxer Paragliding Training App - Screenshots

## Overview
This document showcases the Foxer Paragliding Training Flutter app running on multiple platforms.

## Web Platform (Chrome)

### 1. Splash Screen
- Initial app launch with paragliding icon
- 2-second delay before navigation to login

### 2. Login Screen
**Location:** `screenshots/01-login-screen.png`
- Email and password input fields
- Clean Material Design 3 interface with black/white theme
- "Login" button for authentication
- Test credentials:
  - Email: `test@foxer.com`
  - Password: `password123`
  - (Any non-empty values work)

### 3. Home Screen
- Navigation to main app interface after successful login
- Accessible to authenticated users

## Features Implemented

✅ **Web Platform Support** - App fully functional on Chrome  
✅ **Responsive Design** - Material 3 theme with black/white color scheme  
✅ **Authentication** - Login screen with SharedPreferences persistence  
✅ **Navigation** - SplashScreen → LoginScreen → HomeScreen flow  
✅ **Google Maps Integration** - Configured with API key for map features  
✅ **Responsive UI** - All 7 screens available (Home, Map, Lessons, Reading Materials, Discussions, etc.)

## Build & Run

### Web
```bash
flutter run -d chrome
```

App will launch at `http://localhost:51234`

### Android (when device is available)
```bash
flutter run
```

## Current Status
🟢 **WORKING:** Web app fully functional with login flow and navigation

## Next Steps
- Test on Android device (currently unauthorized)
- Implement actual map functionality
- Add curriculum content to screens
- Integrate backend API for real authentication
