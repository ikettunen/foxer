# Flutter Setup Guide

## Prerequisites

- **Flutter SDK**: [Download Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: Comes with Flutter
- **Android Studio** or **Xcode** (for iOS)
- **Git**: [Download Git](https://git-scm.com/)

## Installation Steps

### 1. Install Flutter

1. Download Flutter from [flutter.dev](https://flutter.dev/docs/get-started/install)
2. Extract to a location (e.g., `C:\src\flutter`)
3. Add Flutter to PATH:
   - **Windows**: Add `C:\src\flutter\bin` to System Environment Variables
   - **macOS/Linux**: Add to `~/.bashrc` or `~/.zshrc`:
     ```bash
     export PATH="$PATH:$HOME/flutter/bin"
     ```

4. Verify installation:
   ```bash
   flutter --version
   dart --version
   ```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Android (for Android development)

1. Open `android/local.properties` and add:
   ```
   sdk.dir=/path/to/android/sdk
   flutter.sdk=/path/to/flutter
   ```

2. Add Google Maps API Key to `android/app/src/main/AndroidManifest.xml`

### 4. Configure iOS (for iOS development)

```bash
cd ios
pod install
cd ..
```

2. Add Google Maps API Key to `ios/Runner/GoogleService-Info.plist`

### 5. Run the App

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d chrome
```

## Troubleshooting

- Run `flutter doctor` to check your setup
- Make sure Android SDK and/or Xcode are properly installed
- Clear build cache: `flutter clean`
- Get latest dependencies: `flutter pub get`

## API Keys

Don't commit API keys to the repository. Use:
- Local configuration files (added to `.gitignore`)
- Environment variables
- Platform-specific secure storage

See [CONTRIBUTING.md](../CONTRIBUTING.md) for more details.
