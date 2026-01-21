import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/device.dart';
import '../../../domain/repositories/device_repository.dart';

// ============================================================================
// EVENTS - What the user/system can do (like commands/messages in embedded)
// ============================================================================

abstract class DevicesEvent extends Equatable {
  const DevicesEvent();

  @override
  List<Object?> get props => [];
}

/// Load all devices
class LoadDevices extends DevicesEvent {}

/// Refresh devices (pull-to-refresh)
class RefreshDevices extends DevicesEvent {}

/// Filter devices by status
class FilterDevices extends DevicesEvent {
  final DeviceStatus? statusFilter;

  const FilterDevices({this.statusFilter});

  @override
  List<Object?> get props => [statusFilter];
}

// ============================================================================
// STATES - Current state of the UI (like state machine states in embedded)
// ============================================================================

abstract class DevicesState extends Equatable {
  const DevicesState();

  @override
  List<Object?> get props => [];
}

/// Initial state - nothing loaded yet
class DevicesInitial extends DevicesState {}

/// Loading state - fetching data
class DevicesLoading extends DevicesState {}

/// Loaded state - data available
class DevicesLoaded extends DevicesState {
  final List<Device> devices;
  final List<Device> filteredDevices;
  final DeviceStatus? activeFilter;

  const DevicesLoaded({
    required this.devices,
    required this.filteredDevices,
    this.activeFilter,
  });

  /// Helper getters for UI
  int get totalCount => devices.length;
  int get onlineCount =>
      devices.where((d) => d.status == DeviceStatus.online).length;
  int get offlineCount =>
      devices.where((d) => d.status == DeviceStatus.offline).length;
  int get lowBatteryCount => devices.where((d) => d.isLowBattery).length;

  @override
  List<Object?> get props => [devices, filteredDevices, activeFilter];
}

/// Error state
class DevicesError extends DevicesState {
  final String message;

  const DevicesError(this.message);

  @override
  List<Object?> get props => [message];
}

// ============================================================================
// BLOC - Business logic component (like a state machine controller)
// ============================================================================

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  final DeviceRepository _repository;

  DevicesBloc({required DeviceRepository repository})
    : _repository = repository,
      super(DevicesInitial()) {
    // Register event handlers (like interrupt handlers)
    on<LoadDevices>(_onLoadDevices);
    on<RefreshDevices>(_onRefreshDevices);
    on<FilterDevices>(_onFilterDevices);
  }

  Future<void> _onLoadDevices(
    LoadDevices event,
    Emitter<DevicesState> emit,
  ) async {
    emit(DevicesLoading());
    await _fetchDevices(emit);
  }

  Future<void> _onRefreshDevices(
    RefreshDevices event,
    Emitter<DevicesState> emit,
  ) async {
    await _fetchDevices(emit);
  }

  Future<void> _fetchDevices(Emitter<DevicesState> emit) async {
    final result = await _repository.getDevices();

    if (result.failure != null) {
      emit(DevicesError(result.failure!.message));
    } else {
      emit(
        DevicesLoaded(devices: result.devices, filteredDevices: result.devices),
      );
    }
  }

  void _onFilterDevices(FilterDevices event, Emitter<DevicesState> emit) {
    final currentState = state;
    if (currentState is DevicesLoaded) {
      final filtered = event.statusFilter == null
          ? currentState.devices
          : currentState.devices
                .where((d) => d.status == event.statusFilter)
                .toList();

      emit(
        DevicesLoaded(
          devices: currentState.devices,
          filteredDevices: filtered,
          activeFilter: event.statusFilter,
        ),
      );
    }
  }
}
