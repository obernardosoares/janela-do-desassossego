import '../entities/device.dart';
import '../../core/error/failures.dart';

/// Abstract repository interface (like a pure virtual class in C++)
/// This defines the contract - implementations can use REST API, local DB, etc.
abstract class DeviceRepository {
  /// Get all devices
  Future<({List<Device> devices, Failure? failure})> getDevices();

  /// Get a single device by ID
  Future<({Device? device, Failure? failure})> getDevice(String id);

  /// Update device configuration
  Future<({bool success, Failure? failure})> updateDevice(Device device);

  /// Watch device status changes (reactive stream)
  Stream<Device> watchDevice(String id);
}
