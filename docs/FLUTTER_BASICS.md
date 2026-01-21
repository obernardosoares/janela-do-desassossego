# Flutter Project Basics

> Understanding Flutter/Dart project structure and development decisions

---

## Project Files Overview

### Core Files

| File | Purpose |
|------|---------|
| `pubspec.yaml` | Project manifest: name, dependencies, assets |
| `lib/main.dart` | App entry point |
| `analysis_options.yaml` | Linter rules |

### Platform Directories

| Directory | Platform |
|-----------|----------|
| `android/` | Android native code, Gradle config |
| `ios/` | iOS native code, Xcode project |
| `linux/` | Linux desktop support |

---

## pubspec.yaml Explained

```yaml
name: janela_do_desassossego        # Package name (snake_case)
description: Smart Living Platform   
version: 1.0.0+1                     # version+build_number

environment:
  sdk: '>=3.0.0 <4.0.0'              # Dart SDK constraint

dependencies:
  flutter:
    sdk: flutter

  # State Management (BLoC - industry standard)
  flutter_bloc: ^8.1.0

  # Navigation
  go_router: ^13.0.0                 # Declarative routing

  # Networking
  dio: ^5.4.0                        # HTTP client
  web_socket_channel: ^2.4.0         # WebSocket

  # Local Storage
  drift: ^2.14.0                     # SQLite with type safety
  flutter_secure_storage: ^9.0.0     # Encrypted key-value

  # Dependency Injection
  get_it: ^7.6.0                     # Service locator

  # UI
  fl_chart: ^0.65.0                  # Charts
  
  # Camera & ML
  camera: ^0.10.5                    # Camera access
  tflite_flutter: ^0.10.0            # TensorFlow Lite

dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.0                   # Mocking
  build_runner: ^2.4.0               # Code generation
```

---

## Why BLoC for State Management?

| Aspect | BLoC | Riverpod |
|--------|------|----------|
| Pattern | Event → State | Provider-based |
| Industry Use | Very common | Growing |
| Testing | Excellent | Excellent |

**Our choice**: BLoC - strict separation, well-documented.

---

## Why Drift for Database?

| Feature | Drift | Hive | SharedPreferences |
|---------|-------|------|-------------------|
| Type safety | ✅ | ❌ | ❌ |
| SQL/Relations | ✅ | ❌ | ❌ |
| Migrations | ✅ | Manual | ❌ |

**Our choice**: Drift - relational data for devices, sessions, rules.

---

## Project Structure

```
lib/
├── main.dart              # Entry point
├── app.dart               # App widget, theme, routing
│
├── core/                  # Shared utilities
│   ├── config/            # Environment, API URLs
│   ├── network/           # Dio client
│   └── theme/             # Colors, typography
│
├── data/                  # Data layer
│   ├── datasources/       # APIs, local DB
│   ├── models/            # DTOs
│   └── repositories/      # Implementations
│
├── domain/                # Business logic
│   ├── entities/          # Core objects
│   └── usecases/          # Business operations
│
└── features/              # Feature modules
    ├── auth/
    ├── dashboard/
    └── devices/
```

---

## Common Commands

```bash
flutter pub get              # Get dependencies
flutter analyze              # Lint code
flutter test                 # Run tests
flutter run                  # Run app
flutter build apk --release  # Build Android
flutter build ios --release  # Build iOS (macOS only)
```

---

## Code Generation

After modifying annotated files:
```bash
dart run build_runner build --delete-conflicting-outputs
```
