import 'dart:async';

import 'package:flutter/material.dart';

import '../models/greenhouse_data.dart';
import '../models/sensor.dart';
import '../services/greenhouse_service.dart';

class GreenhouseScreen extends StatefulWidget {
  const GreenhouseScreen({super.key});

  @override
  State<GreenhouseScreen> createState() => _GreenhouseScreenState();
}

class _GreenhouseScreenState extends State<GreenhouseScreen> {
  late final GreenhouseService _service;
  late Future<GreenhouseData> _initialData;

  StreamSubscription<List<Sensor>>? _sensorSubscription;
  List<Sensor> _sensors = [];
  String _dailySummary = '';
  bool _paused = false;
  bool _showingLoadError = false;
  final Map<String, DateTime> _lastSnackBar = {};

  @override
  void initState() {
    super.initState();
    _service = GreenhouseService(failureRate: 0.2);
    _initialData = _loadData();
  }

  Future<GreenhouseData> _loadData() async {
    try {
      final data = await _service.loadInitialData()
          .timeout(const Duration(seconds: 3));

      if (!mounted) {
        return data;
      }

      setState(() {
        _sensors = data.sensors;
        _dailySummary = data.dailySummary;
        _showingLoadError = false;
      });

      _startListening();
      _service.startUpdates();

      return data;
    } catch (_) {
      if (mounted) {
        setState(() {
          _showingLoadError = true;
        });
      }
      rethrow;
    }
  }

  void _startListening() {
    _sensorSubscription ??= _service.sensorStream.listen(
      (sensors) {
        if (!mounted) return;

        setState(() {
          _sensors = sensors;
        });

        for (final sensor in sensors) {
          if (sensor.isOutOfRange) {
            _showThresholdWarning(sensor);
          }
        }
      },
      onError: (Object error) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Помилка одного з датчиків: $error'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }

  void _showThresholdWarning(Sensor sensor) {
    final now = DateTime.now();
    final last = _lastSnackBar[sensor.id];

    if (last != null && now.difference(last).inSeconds < 10) {
      return;
    }

    _lastSnackBar[sensor.id] = now;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Увага! ${sensor.name}: ${sensor.value} ${sensor.unit}',
        ),
        backgroundColor: Colors.red.shade700,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _retryLoading() async {
    setState(() {
      _showingLoadError = false;
      _sensors = [];
      _dailySummary = '';
      _initialData = _loadData();
    });
  }

  void _togglePause() {
    if (_paused) {
      _service.resumeUpdates();
    } else {
      _service.pauseUpdates();
    }

    setState(() {
      _paused = !_paused;
    });
  }

  @override
  void dispose() {
    _sensorSubscription?.cancel();
    _service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Розумна теплиця'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _togglePause,
            tooltip: _paused ? 'Продовжити' : 'Пауза',
            icon: Icon(_paused ? Icons.play_arrow : Icons.pause),
          ),
        ],
      ),
      body: FutureBuilder<GreenhouseData>(
        future: _initialData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !_showingLoadError) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Завантаження даних теплиці...'),
                ],
              ),
            );
          }

          if (snapshot.hasError || _showingLoadError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.cloud_off,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Не вдалося завантажити дані',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    const Text('Сервер недоступний або минув тайм-аут.'),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _retryLoading,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Повторити'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (_sensors.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.sensors_off, size: 56),
                  const SizedBox(height: 12),
                  const Text('Датчиків поки немає'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _retryLoading,
                    child: const Text('Завантажити знову'),
                  ),
                ],
              ),
            );
          }

          return StreamBuilder<List<Sensor>>(
            stream: _service.sensorStream,
            initialData: _sensors,
            builder: (context, streamSnapshot) {
              final sensors = streamSnapshot.data ?? _sensors;

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    color: Colors.green.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.eco, color: Colors.green),
                              SizedBox(width: 8),
                              Text(
                                'Стан теплиці',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _paused
                                ? 'Оновлення призупинено'
                                : 'Датчики оновлюються в реальному часі',
                          ),
                          const SizedBox(height: 12),
                          Text(_dailySummary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final sensor in sensors) _buildSensorCard(sensor),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: _togglePause,
                    icon: Icon(
                      _paused ? Icons.play_arrow : Icons.pause,
                    ),
                    label: Text(
                      _paused ? 'Продовжити оновлення' : 'Пауза оновлень',
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      padding: const EdgeInsets.all(14),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Дані демонстраційні. Справжні датчики не підключені.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSensorCard(Sensor sensor) {
    final color = sensor.hasError
        ? Colors.grey
        : sensor.isOutOfRange
            ? Colors.red
            : Colors.green;

    final icon = switch (sensor.id) {
      'temperature' => Icons.thermostat,
      'humidity' => Icons.water_drop,
      _ => Icons.light_mode,
    };

    return Card(
      color: sensor.isOutOfRange
          ? Colors.red.shade50
          : sensor.hasError
              ? Colors.grey.shade200
              : null,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sensor.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sensor.hasError
                        ? 'Датчик тимчасово недоступний'
                        : '${sensor.value} ${sensor.unit}',
                    style: TextStyle(
                      fontSize: 22,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Норма: ${sensor.minThreshold}–'
                    '${sensor.maxThreshold} ${sensor.unit}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  if (sensor.isOutOfRange)
                    const Text(
                      'Перевищено поріг!',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              sensor.hasError
                  ? Icons.error_outline
                  : sensor.isOutOfRange
                      ? Icons.warning_amber
                      : Icons.check_circle,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}