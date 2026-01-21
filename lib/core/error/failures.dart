import 'package:equatable/equatable.dart';

/// Base failure class for error handling
/// Similar to Result/Optional patterns in C++
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Network error occurred'});
}

/// Server-side failures (HTTP 5xx)
class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error occurred', super.code});
}

/// Authentication failures
class AuthFailure extends Failure {
  const AuthFailure({super.message = 'Authentication failed'});
}

/// Cache/storage failures
class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error occurred'});
}

/// Device communication failures
class DeviceFailure extends Failure {
  final String? deviceId;

  const DeviceFailure({
    super.message = 'Device communication failed',
    this.deviceId,
  });

  @override
  List<Object?> get props => [...super.props, deviceId];
}
