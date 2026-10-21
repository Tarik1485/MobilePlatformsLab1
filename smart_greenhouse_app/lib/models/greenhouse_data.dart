import 'sensor.dart';

class GreenhouseData {
  final List<Sensor> sensors;
  final String dailySummary;
  final DateTime loadedAt;

  const GreenhouseData({
    required this.sensors,
    required this.dailySummary,
    required this.loadedAt,
  });
}