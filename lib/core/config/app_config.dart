/// App configuration for different environments
class AppConfig {
  final String apiBaseUrl;
  final String mqttBrokerUrl;
  final bool isProduction;

  const AppConfig({
    required this.apiBaseUrl,
    required this.mqttBrokerUrl,
    required this.isProduction,
  });

  /// Development configuration (local server)
  static const dev = AppConfig(
    apiBaseUrl: 'http://localhost:8080/api/v1',
    mqttBrokerUrl: 'ws://localhost:1883',
    isProduction: false,
  );

  /// Production configuration (cloud)
  static const prod = AppConfig(
    apiBaseUrl: 'https://api.portugalfuturista.pt/v1',
    mqttBrokerUrl: 'wss://mqtt.portugalfuturista.pt',
    isProduction: true,
  );

  /// Self-hosted configuration
  static AppConfig selfHosted(String serverIp) => AppConfig(
    apiBaseUrl: 'http://$serverIp:8080/api/v1',
    mqttBrokerUrl: 'ws://$serverIp:1883',
    isProduction: false,
  );
}
