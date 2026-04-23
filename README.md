# Paragliding Training App

A Flutter application for paragliding training with flight site maps, lessons, reading materials, and discussions.

## Features

- **Splash Screen**: Initial loading screen with branding
- **One-time Login**: Simple authentication that persists
- **Flight Sites Map**: Interactive map showing paragliding locations
- **Lessons**: Structured training modules
- **Reading Materials**: Access to guides and manuals
- **Discussions**: Community forum for pilots

## Setup

1. Install Flutter dependencies:
   ```
   flutter pub get
   ```

2. Add your Google Maps API key:
   - Get an API key from [Google Cloud Console](https://console.cloud.google.com/)
   - Replace `YOUR_API_KEY_HERE` in `android/app/src/main/AndroidManifest.xml`
   - For iOS, add the key to `ios/Runner/AppDelegate.swift`

3. Run the app:
   ```
   flutter run
   ```

## Project Structure

- `lib/main.dart` - App entry point
- `lib/screens/` - All screen implementations
  - `splash_screen.dart` - Initial splash screen
  - `login_screen.dart` - One-time login
  - `home_screen.dart` - Main navigation
  - `map_screen.dart` - Flight sites map
  - `lessons_screen.dart` - Training lessons
  - `reading_materials_screen.dart` - Documents and guides
  - `discussions_screen.dart` - Community discussions

## Dependencies

- `google_maps_flutter` - Map integration
- `shared_preferences` - Local storage for login state
