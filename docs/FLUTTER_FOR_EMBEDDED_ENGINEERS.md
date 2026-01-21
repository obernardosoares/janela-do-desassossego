# Flutter for Embedded Engineers

> A guide for C/C++ developers transitioning to Flutter/Dart

---

## Core Concepts Comparison

| C/C++ | Dart/Flutter | Notes |
|-------|--------------|-------|
| `struct` | `class` | Dart classes are more flexible |
| `enum` | `enum` | Similar, but Dart enums can have methods |
| Pointers | References | Dart handles memory automatically (GC) |
| `malloc/free` | Automatic | No manual memory management |
| Header files | `import` | No .h/.c split - single file |
| Makefile | `pubspec.yaml` | Dependency and build configuration |
| `#define` | `const` / `final` | Compile-time vs runtime constants |
| Callbacks | `async/await` | Dart uses Futures and Streams |
| Mutex/Semaphore | Not needed* | Single-threaded, event-loop based |

*Dart is single-threaded with an event loop (like Arduino's `loop()`), so no race conditions in typical code.

---

## Memory Model

### C/C++
```c
// Manual allocation
Device* dev = malloc(sizeof(Device));
dev->id = "abc";
// Must remember to free
free(dev);
```

### Dart
```dart
// Automatic allocation and garbage collection
final dev = Device(id: 'abc');
// No free needed - GC handles it
```

**Key difference**: Dart uses garbage collection. You create objects, use them, and the runtime cleans them up. No memory leaks from forgetting to free.

---

## Asynchronous Programming

### C (Embedded)
```c
// Blocking wait
while (!data_ready) {
    vTaskDelay(10 / portTICK_PERIOD_MS);
}
process_data();

// Or callbacks
void data_callback(uint8_t* data) {
    process_data(data);
}
register_callback(data_callback);
```

### Dart
```dart
// Await (non-blocking, but reads like sync code)
final data = await fetchData();  // Waits here, but doesn't block thread
processData(data);

// Or Streams (like continuous callbacks)
dataStream.listen((data) {
    processData(data);
});
```

**Key insight**: `await` is like a non-blocking `while(!ready)` loop - it yields control and resumes when data arrives.

---

## State Machines (BLoC Pattern)

As an embedded engineer, you're familiar with state machines. BLoC is exactly that!

### Embedded FSM
```c
typedef enum { IDLE, LOADING, LOADED, ERROR } state_t;
typedef enum { LOAD_CMD, REFRESH_CMD } event_t;

state_t current_state = IDLE;

void handle_event(event_t event) {
    switch (current_state) {
        case IDLE:
            if (event == LOAD_CMD) {
                current_state = LOADING;
                start_fetch();
            }
            break;
        case LOADING:
            // ... handle callbacks
            break;
    }
}
```

### Flutter BLoC
```dart
// Events (like your event_t enum)
abstract class DevicesEvent {}
class LoadDevices extends DevicesEvent {}
class RefreshDevices extends DevicesEvent {}

// States (like your state_t enum)
abstract class DevicesState {}
class DevicesIdle extends DevicesState {}
class DevicesLoading extends DevicesState {}
class DevicesLoaded extends DevicesState {
  final List<Device> devices;
  DevicesLoaded(this.devices);
}

// Bloc (like your handle_event function)
class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  DevicesBloc() : super(DevicesIdle()) {
    on<LoadDevices>((event, emit) async {
      emit(DevicesLoading());
      final devices = await fetchDevices();
      emit(DevicesLoaded(devices));
    });
  }
}
```

**Same concept, different syntax!**

---

## Immutability (Why `copyWith`?)

### C (Mutable)
```c
Device dev = {.id = "abc", .battery = 100};
dev.battery = 50;  // Mutated in place
```

### Dart (Immutable Pattern)
```dart
final dev = Device(id: 'abc', battery: 100);
// dev.battery = 50;  // ERROR - fields are final

// Create new instance with changed field
final updated = dev.copyWith(battery: 50);
// Original `dev` unchanged - good for debugging!
```

**Why?** Immutability prevents bugs where one part of code changes data unexpectedly. The UI always knows exactly what changed.

---

## Widgets = UI Components

Think of widgets like hardware abstraction layers, but for UI:

```dart
// A "Button" is like a HAL for a button component
ElevatedButton(
  onPressed: () => handlePress(),  // "interrupt handler"
  child: Text('Click Me'),
)

// Compose them like composing modules
Column(  // Vertical layout
  children: [
    Text('Status: Online'),
    ElevatedButton(...),
    Icon(Icons.battery_full),
  ],
)
```

---

## Project Structure Mapping

```
Embedded Project           →  Flutter Project
├── src/                   →  lib/
│   ├── main.c             →  main.dart
│   ├── drivers/           →  core/network/
│   ├── hal/               →  data/datasources/
│   ├── app/               →  features/
│   └── utils/             →  core/
├── test/                  →  test/
├── Makefile               →  pubspec.yaml
└── build/                 →  build/ (auto-generated)
```

---

## Testing

### Embedded (Unity/CUnit)
```c
void test_battery_low(void) {
    Device dev = {.battery = 15};
    TEST_ASSERT_TRUE(is_low_battery(&dev));
}
```

### Flutter
```dart
test('should detect low battery when level < 20', () {
  final dev = Device(batteryLevel: 15);
  expect(dev.isLowBattery, true);
});
```

**Same pattern**: Arrange (setup) → Act (call function) → Assert (check result).

---

## Quick Reference

| Task | Command |
|------|---------|
| Build | `flutter build apk` |
| Run | `flutter run` |
| Test | `flutter test` |
| Analyze | `flutter analyze` |
| Get deps | `flutter pub get` |

---

## Next Steps

1. Read `lib/domain/entities/device.dart` - see how entities work
2. Read `lib/features/devices/bloc/devices_bloc.dart` - see BLoC pattern
3. Run `flutter test` to see tests execute
4. Read `lib/core/theme/app_theme.dart` - see design tokens
