class Sensor {
  final String id;
  final String name;
  final String unit;
  final double value;
  final double minThreshold;
  final double maxThreshold;
  final bool hasError;

  const Sensor({
    required this.id,
    required this.name,
    required this.unit,
    required this.value,
    required this.minThreshold,
    required this.maxThreshold,
    this.hasError = false,
  });

  bool get isOutOfRange =>
      !hasError && (value < minThreshold || value > maxThreshold);

  Sensor copyWith({
    double? value,
    bool? hasError,
  }) {
    return Sensor(
      id: id,
      name: name,
      unit: unit,
      value: value ?? this.value,
      minThreshold: minThreshold,
      maxThreshold: maxThreshold,
      hasError: hasError ?? this.hasError,
    );
  }
}