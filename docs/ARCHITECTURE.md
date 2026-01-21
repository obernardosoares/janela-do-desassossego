# Architecture Guide

> Clean Architecture for Flutter - patterns and reasoning

---

## Layers Overview

```
┌─────────────────────────────────────────────────────────────┐
│                   PRESENTATION (UI)                          │
│  Widgets, Screens, BLoCs                                    │
│  Depends on: Domain                                         │
├─────────────────────────────────────────────────────────────┤
│                      DOMAIN (Business Logic)                 │
│  Entities, Repositories (interfaces), UseCases              │
│  Depends on: Nothing (pure Dart)                            │
├─────────────────────────────────────────────────────────────┤
│                      DATA (Implementation)                   │
│  Repositories (impl), DataSources, Models                   │
│  Depends on: Domain                                         │
└─────────────────────────────────────────────────────────────┘
```

---

## Folder Structure

```
lib/
├── main.dart              # Entry point
├── app.dart               # App widget with routing & theme
│
├── core/                  # Shared code (no feature deps)
│   ├── config/            # Environment configuration
│   ├── error/             # Failure classes
│   ├── network/           # HTTP client, WebSocket
│   └── theme/             # Colors, typography, ThemeData
│
├── data/                  # Data layer
│   ├── datasources/       # API clients, local DB
│   ├── models/            # DTOs with JSON serialization
│   └── repositories/      # Concrete repository implementations
│
├── domain/                # Business logic (pure Dart)
│   ├── entities/          # Core business objects
│   ├── repositories/      # Abstract interfaces
│   └── usecases/          # Single-purpose operations
│
└── features/              # Feature modules
    ├── auth/
    │   ├── bloc/          # Auth state management
    │   ├── screens/       # Login, Register screens
    │   └── widgets/       # Auth-specific widgets
    ├── dashboard/
    ├── devices/
    ├── camera_ml/
    ├── automation/
    └── settings/
```

---

## Dependency Rule

**CRITICAL**: Dependencies flow inward only!

```
UI → Domain ← Data
     (pure)
```

- `domain/` has NO imports from other layers
- `data/` imports from `domain/` only
- `features/` imports from `domain/` and `core/`

---

## Example Flow

User taps "Load Devices":

```
1. [UI] DevicesScreen button tap
   └── dispatches LoadDevices event to BLoC

2. [BLoC] DevicesBloc receives event
   └── calls DeviceRepository.getDevices()

3. [Domain] DeviceRepository (interface)
   └── implemented by DeviceRepositoryImpl

4. [Data] DeviceRepositoryImpl
   └── calls ApiDataSource.fetchDevices()
   └── maps JSON to Device entities
   └── returns List<Device>

5. [BLoC] receives devices
   └── emits DevicesLoaded state

6. [UI] rebuilds with new state
   └── displays device list
```

---

## Key Files Explained

| File | Purpose |
|------|---------|
| `domain/entities/device.dart` | What a Device IS (properties, computed values) |
| `domain/repositories/device_repository.dart` | What we can DO with devices (interface) |
| `features/devices/bloc/devices_bloc.dart` | UI logic: events → states |
| `core/error/failures.dart` | Error types (like errno codes) |
| `core/theme/app_theme.dart` | Visual design tokens |

---

## Testing Strategy

| Layer | Test Type | Example |
|-------|-----------|---------|
| `domain/entities/` | Unit | `device_test.dart` |
| `domain/usecases/` | Unit | Mock repository |
| `features/*/bloc/` | Unit | `bloc_test` package |
| `data/repositories/` | Integration | Mock data source |
| `features/*/screens/` | Widget | `flutter_test` |
