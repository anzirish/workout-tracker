# Workout Tracker Mobile App

Flutter mobile application for tracking workouts with authentication and streak tracking.

## Tech Stack

- Flutter (Dart)
- GetX - State management
- Dio - HTTP client
- Material Design 3

## Setup

### Prerequisites

- Flutter SDK (3.0+)
- Android Studio / Xcode
- Android device or emulator

### Installation

1. Install dependencies:
```bash
flutter pub get
```

2. Configure API endpoint:

Edit `lib/config/app_config.dart`:
```dart
class AppConfig {
  // For physical device, use your PC's IP address
  static const String baseUrl = 'http://192.168.1.100:3000/api';
  
  // For emulator, use:
  // Android: http://10.0.2.2:3000/api
  // iOS: http://localhost:3000/api
  
  static const int userId = 1; // Default user ID
}
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
mobile/
├── lib/
│   ├── config/
│   │   └── app_config.dart        # API configuration
│   ├── controllers/
│   │   ├── workout_controller.dart    # Workout state management
│   │   └── history_controller.dart    # History state management
│   ├── models/
│   │   ├── workout.dart               # Workout model
│   │   ├── workout_history.dart       # History model
│   │   └── streak_data.dart           # Streak model
│   ├── screens/
│   │   ├── workout_list_screen.dart   # Main workout list
│   │   ├── workout_detail_screen.dart # Workout details
│   │   └── workout_history_screen.dart # History & streak
│   ├── services/
│   │   └── api_service.dart           # API calls with Dio
│   └── main.dart                      # Entry point
├── pubspec.yaml
└── README.md
```

## Features

- View available workouts
- Mark workouts as complete
- Track workout history
- View current streak
- Pull-to-refresh
- Loading states
- Error handling

## Running on Device

### Android (USB)

1. Enable Developer Options on your phone
2. Enable USB Debugging
3. Connect via USB
4. Run: `flutter run`

### Android (Wireless)

1. Enable Wireless Debugging in Developer Options
2. Pair device: `adb pair <IP:PORT>`
3. Connect: `adb connect <IP:PORT>`
4. Run: `flutter run`

### Build APK

```bash
flutter build apk --release
```

APK location: `build/app/outputs/flutter-apk/app-release.apk`

## State Management

Using GetX for reactive state management:

```dart
// Observable state
final workouts = <Workout>[].obs;

// UI automatically rebuilds
Obx(() => Text(controller.workouts.length.toString()))
```

## API Integration

All API calls are in `services/api_service.dart`:

```dart
final ApiService _api = ApiService();
final workouts = await _api.getWorkouts();
```

## Development

### Hot Reload

Press `r` in terminal to hot reload changes instantly.

### Hot Restart

Press `R` in terminal to restart the app.

### Debug

Press `d` to open DevTools.

## Dependencies

- get: ^4.6.6 - State management
- dio: ^5.4.0 - HTTP client
- intl: ^0.19.0 - Date formatting

## Troubleshooting

### Cannot connect to API

- Check API base URL in `app_config.dart`
- Use your PC's IP address, not `localhost`
- Ensure backend is running
- Check firewall settings

### Build fails

```bash
flutter clean
flutter pub get
flutter run
```

### Gradle build slow

First build takes 5-10 minutes. Subsequent builds are faster.

## Find Your PC's IP

**Windows:**
```bash
ipconfig
```
Look for "IPv4 Address"

**Mac/Linux:**
```bash
ifconfig
```
Look for "inet" address
