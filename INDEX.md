# Service Product Marketplace App - Project Index

## Project Overview
This is a Flutter-based service product marketplace application.

## Directory Structure

### Core Directories
- `lib/` - Main source code directory
  - `configs/` - Configuration files and settings
  - `widgets/` - Reusable UI components
  - `pages/` - Application pages
  - `screens/` - Screen implementations
  - `utils/` - Utility functions and helpers
  - `constants/` - Application constants
  - `notifications/` - Notification handling

### Key Files
- `main.dart` - Application entry point
- `screen_routes.dart` - Route definitions
- `firebase_options.dart` - Firebase configuration
- `actions.dart` - Application actions
- `constants.dart` - Global constants

### Platform-Specific Directories
- `android/` - Android platform-specific code
- `ios/` - iOS platform-specific code
- `web/` - Web platform-specific code
- `linux/` - Linux platform-specific code
- `macos/` - macOS platform-specific code
- `windows/` - Windows platform-specific code

### Configuration Files
- `pubspec.yaml` - Flutter project dependencies
- `analysis_options.yaml` - Dart analysis options
- `firebase.json` - Firebase configuration
- `.firebaserc` - Firebase project configuration
- `flutter_native_splash.yaml` - Splash screen configuration

### Assets
- `assets/` - Application assets (images, fonts, etc.)

### Documentation
- `README.md` - Project documentation
- `CHANGELOG.md` - Version history and changes

## Dependencies
The project uses:
- Flutter SDK
- Firebase services
- Various Flutter packages (see `pubspec.yaml` for details)

## Development Setup
1. Ensure Flutter SDK is installed
2. Run `flutter pub get` to install dependencies
3. Configure Firebase if needed
4. Run the application using `flutter run`

## Testing
- `test/` directory contains test files
- Run tests using `flutter test`

## Build and Deployment
- Use `flutter build` commands for different platforms
- Firebase deployment configuration available 