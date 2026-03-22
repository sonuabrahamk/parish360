# parish360_mobile

**Parish360** is a Flutter mobile app for parish/offline community management.

## Project Overview

- Based on Flutter with Android, iOS, Linux, Windows, and Web targets.
- Features modules in `lib/features/`: `auth`, `families`, `members`.
- Core utilities in `lib/core/`: `app`, `config`, `error`, `network`, `utils`.

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0)
- Dart SDK (comes with Flutter)
- Android Studio / Xcode (mobile emulators)

### Setup

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Run (dev mode)

```bash
flutter run -d <device_id>
```

### Build

- Android: `flutter build apk`
- iOS: `flutter build ios`
- Web: `flutter build web`

## Development

- Entry points: `lib/main.dart`, `lib/main_dev.dart`, `lib/app.dart`
- App dependencies are in `pubspec.yaml`
- Android project in `android/app`; iOS project in `ios/Runner`

## Testing

```bash
flutter test
```

## Notes

- Keep assets under `assets/images/`.
- Ensure `local.properties` has correct SDK paths for Android.
- This README is updated to match the actual project structure and commands.
