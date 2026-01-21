import 'package:flutter_test/flutter_test.dart';
import 'package:janela_do_desassossego/domain/entities/device.dart';

void main() {
  group('Device Entity', () {
    // Create a test device (like test fixtures in C)
    final testDevice = Device(
      id: 'A4:CF:12:34:56:78',
      roomId: 'room-101',
      name: 'Bathroom Sensor',
      status: DeviceStatus.online,
      lastSeenAt: DateTime(2026, 1, 21),
      firmwareVersion: 'v1.0.0',
      batteryLevel: 85,
      rssi: -65,
      type: DeviceType.waterSensor,
    );

    test('should detect low battery when level < 20', () {
      // Arrange
      final lowBatteryDevice = testDevice.copyWith(batteryLevel: 15);

      // Act & Assert
      expect(lowBatteryDevice.isLowBattery, true);
      expect(testDevice.isLowBattery, false);
    });

    test('should detect weak signal when rssi < -80 dBm', () {
      // Arrange
      final weakSignalDevice = testDevice.copyWith(rssi: -85);

      // Act & Assert
      expect(weakSignalDevice.isWeakSignal, true);
      expect(testDevice.isWeakSignal, false);
    });

    test('should need attention when offline or low battery', () {
      // Arrange
      final offlineDevice = testDevice.copyWith(status: DeviceStatus.offline);
      final lowBatteryDevice = testDevice.copyWith(batteryLevel: 10);
      final errorDevice = testDevice.copyWith(status: DeviceStatus.error);

      // Act & Assert
      expect(testDevice.needsAttention, false);
      expect(offlineDevice.needsAttention, true);
      expect(lowBatteryDevice.needsAttention, true);
      expect(errorDevice.needsAttention, true);
    });

    test('copyWith should create new instance with updated fields', () {
      // Arrange & Act
      final updated = testDevice.copyWith(
        name: 'Kitchen Sensor',
        batteryLevel: 50,
      );

      // Assert - original unchanged (immutability)
      expect(testDevice.name, 'Bathroom Sensor');
      expect(testDevice.batteryLevel, 85);

      // Assert - new instance has updates
      expect(updated.name, 'Kitchen Sensor');
      expect(updated.batteryLevel, 50);

      // Assert - other fields copied
      expect(updated.id, testDevice.id);
      expect(updated.rssi, testDevice.rssi);
    });

    test('equality should compare by value (Equatable)', () {
      // Arrange
      final device1 = Device(
        id: 'device-1',
        status: DeviceStatus.online,
        lastSeenAt: DateTime(2026, 1, 21),
        firmwareVersion: 'v1.0.0',
        batteryLevel: 100,
        rssi: -50,
      );

      final device2 = Device(
        id: 'device-1',
        status: DeviceStatus.online,
        lastSeenAt: DateTime(2026, 1, 21),
        firmwareVersion: 'v1.0.0',
        batteryLevel: 100,
        rssi: -50,
      );

      // Assert - same values = equal
      expect(device1, equals(device2));
    });
  });
}
