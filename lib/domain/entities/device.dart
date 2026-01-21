import 'package:equatable/equatable.dart';

/// Device status enumeration
enum DeviceStatus { online, offline, provisioning, error }

/// Device type enumeration
enum DeviceType { waterSensor, plantMonitor, smartPlug, camera, generic }

/// Device entity - core business object
/// Note: Equatable enables value comparison (like struct comparison in C)
class Device extends Equatable {
  final String id;
  final String? roomId;
  final String? name;
  final DeviceStatus status;
  final DateTime lastSeenAt;
  final String firmwareVersion;
  final int batteryLevel; // 0-100
  final int rssi; // dBm
  final DeviceType type;

  const Device({
    required this.id,
    this.roomId,
    this.name,
    required this.status,
    required this.lastSeenAt,
    required this.firmwareVersion,
    required this.batteryLevel,
    required this.rssi,
    this.type = DeviceType.generic,
  });

  /// Check if battery is low (< 20%)
  bool get isLowBattery => batteryLevel < 20;

  /// Check if signal is weak (< -80 dBm)
  bool get isWeakSignal => rssi < -80;

  /// Check if device needs attention
  bool get needsAttention =>
      status == DeviceStatus.offline ||
      status == DeviceStatus.error ||
      isLowBattery;

  /// Create a copy with modified fields (immutability pattern)
  Device copyWith({
    String? id,
    String? roomId,
    String? name,
    DeviceStatus? status,
    DateTime? lastSeenAt,
    String? firmwareVersion,
    int? batteryLevel,
    int? rssi,
    DeviceType? type,
  }) {
    return Device(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      name: name ?? this.name,
      status: status ?? this.status,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      firmwareVersion: firmwareVersion ?? this.firmwareVersion,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      rssi: rssi ?? this.rssi,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
    id,
    roomId,
    name,
    status,
    lastSeenAt,
    firmwareVersion,
    batteryLevel,
    rssi,
    type,
  ];
}
