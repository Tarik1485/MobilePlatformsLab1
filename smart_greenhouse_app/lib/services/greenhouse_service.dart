import 'dart:async';
import 'dart:math';

import '../models/greenhouse_data.dart';
import '../models/sensor.dart';

class GreenhouseService {
  GreenhouseService({
    this.failureRate = 0.2,
    Random? random,
  }) : _random = random ?? Random();

  final double failureRate;
  final Random _random;

  final StreamController<List<Sensor>> _sensorController =
      StreamController<List<Sensor>>.broadcast();

  Timer? _timer;
  bool _paused = false;
  bool _disposed = false;

  List<Sensor> _sensors = [];
  final Map<String, DateTime> _lastWarnings = {};

  Stream<List<Sensor>> get sensorStream => _sensorController.stream;

  bool get isPaused => _paused;

  Future<T> _request<T>(T Function() response, {int delayMs = 700}) async {
    await Future<void>.delayed(Duration(milliseconds: delayMs));

    if (_random.nextDouble() < failureRate) {
      throw StateError('Сервер недоступний');
    }

    return response();
  }

  Future<List<Sensor>> _loadSensors() {
    return _request(() => [
          const Sensor(
            id: 'temperature',
            name: 'Температура',
            unit: '°C',
            value: 24.0,
            minThreshold: 18,
            maxThreshold: 30,
          ),
          const Sensor(
            id: 'humidity',
            name: 'Вологість',
            unit: '%',
            value: 65.0,
            minThreshold: 40,
            maxThreshold: 80,
          ),
          const Sensor(
            id: 'light',
            name: 'Освітленість',
            unit: 'лк',
            value: 12000,
            minThreshold: 5000,
            maxThreshold: 25000,
          ),
        ]);
  }

  Future<Map<String, double>> _loadThresholds() {
    return _request(() => {
          'temperatureMin': 18,
          'temperatureMax': 30,
          'humidityMin': 40,
          'humidityMax': 80,
          'lightMin': 5000,
          'lightMax': 25000,
        });
  }

  Future<String> _loadDailySummary() {
    return _request(
      () => 'Середня температура: 23.5 °C · Вологість: 64 %',
    );
  }

  Future<GreenhouseData> loadInitialData() async {
    final results = await Future.wait<dynamic>([
      _loadSensors(),
      _loadThresholds(),
      _loadDailySummary(),
    ]).timeout(const Duration(seconds: 3));

    final sensors = results[0] as List<Sensor>;
    final thresholds = results[1] as Map<String, double>;
    final summary = results[2] as String;

    _sensors = sensors.map((sensor) {
      switch (sensor.id) {
        case 'temperature':
          return Sensor(
            id: sensor.id,
            name: sensor.name,
            unit: sensor.unit,
            value: sensor.value,
            minThreshold: thresholds['temperatureMin']!,
            maxThreshold: thresholds['temperatureMax']!,
          );
        case 'humidity':
          return Sensor(
            id: sensor.id,
            name: sensor.name,
            unit: sensor.unit,
            value: sensor.value,
            minThreshold: thresholds['humidityMin']!,
            maxThreshold: thresholds['humidityMax']!,
          );
        default:
          return Sensor(
            id: sensor.id,
            name: sensor.name,
            unit: sensor.unit,
            value: sensor.value,
            minThreshold: thresholds['lightMin']!,
            maxThreshold: thresholds['lightMax']!,
          );
      }
    }).toList();

    return GreenhouseData(
      sensors: List.unmodifiable(_sensors),
      dailySummary: summary,
      loadedAt: DateTime.now(),
    );
  }

  void startUpdates() {
    if (_disposed || _paused || _timer != null) return;

    _timer = Timer.periodic(
      const Duration(milliseconds: 1500),
      (_) => _updateSensors(),
    );
  }

  void _updateSensors() {
    if (_disposed || _paused || _sensorController.isClosed) return;

    final updated = <Sensor>[];

    for (final sensor in _sensors) {
      if (_random.nextDouble() < failureRate * 0.15) {
        updated.add(sensor.copyWith(hasError: true));
        _sensorController.addError(
          StateError('Помилка датчика: ${sensor.name}'),
          StackTrace.current,
        );
        continue;
      }

      double nextValue;

      switch (sensor.id) {
        case 'temperature':
          nextValue = (20 + _random.nextDouble() * 16);
          break;
        case 'humidity':
          nextValue = (30 + _random.nextDouble() * 60);
          break;
        default:
          nextValue = (2000 + _random.nextDouble() * 30000);
      }

      final nextSensor = Sensor(
        id: sensor.id,
        name: sensor.name,
        unit: sensor.unit,
        value: double.parse(nextValue.toStringAsFixed(1)),
        minThreshold: sensor.minThreshold,
        maxThreshold: sensor.maxThreshold,
      );

      if (nextSensor.isOutOfRange) {
        final now = DateTime.now();
        final last = _lastWarnings[sensor.id];

        if (last == null || now.difference(last).inSeconds >= 10) {
          _lastWarnings[sensor.id] = now;
          // Екран отримає ці дані й покаже попередження.
        }
      }

      updated.add(nextSensor);
    }

    _sensors = updated;
    _sensorController.add(List.unmodifiable(_sensors));
  }

  void pauseUpdates() {
    if (_disposed) return;
    _paused = true;
    _timer?.cancel();
    _timer = null;
  }

  void resumeUpdates() {
    if (_disposed || !_paused) return;
    _paused = false;
    startUpdates();
  }

  void dispose() {
    if (_disposed) return;

    _disposed = true;
    _timer?.cancel();
    _timer = null;
    _sensorController.close();
  }
}