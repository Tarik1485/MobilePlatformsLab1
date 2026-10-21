import 'dart:math';

void main() {
  print('=== Dart Functions Demo ===');

  testBasicFunctions();
  testAdvancedFunctions();
  testFunctionalProgramming();
  demonstrateCalculator();
  demonstrateTextAnalyzer();
}

void testBasicFunctions() {
  print('\n--- Basic Functions ---');

  print('Sum: ${calculateSum(10, 20)}');
  print('Average: ${calculateAverage([10, 20, 30, 40])}');
  print('Formatted name: ${formatName('Taras', 'Kabanets')}');
  print(
    'Full name: ${formatName('Taras', 'Kabanets', middleName: 'Ivanovych', uppercase: true)}',
  );
}

int calculateSum(int a, int b) {
  return a + b;
}

double calculateAverage(List<double> numbers) {
  if (numbers.isEmpty) {
    return 0;
  }

  double sum = numbers.reduce((a, b) => a + b);
  return sum / numbers.length;
}

String formatName(
  String firstName,
  String lastName, {
  String? middleName,
  bool uppercase = false,
}) {
  String fullName = [
    firstName,
    if (middleName != null && middleName.isNotEmpty) middleName,
    lastName,
  ].join(' ');

  return uppercase ? fullName.toUpperCase() : fullName;
}

void testAdvancedFunctions() {
  print('\n--- Advanced Functions ---');

  print('Fibonacci(10): ${fibonacci(10)}');
  print('Factorial(5): ${factorial(5)}');
  print('Power(2, 4): ${power(2, 4)}');
}

int fibonacci(int n) {
  if (n < 0) {
    throw ArgumentError('n must not be negative');
  }

  if (n <= 1) {
    return n;
  }

  int previous = 0;
  int current = 1;

  for (int i = 2; i <= n; i++) {
    int next = previous + current;
    previous = current;
    current = next;
  }

  return current;
}

int factorial(int n) {
  if (n < 0) {
    throw ArgumentError('n must not be negative');
  }

  if (n <= 1) {
    return 1;
  }

  return n * factorial(n - 1);
}

double power(double base, int exponent) {
  return pow(base, exponent).toDouble();
}

void testFunctionalProgramming() {
  print('\n--- Functional Programming ---');

  List<int> numbers = [1, 2, 3, 4, 5, 6];

  List<int> doubled = numbers.map((number) => number * 2).toList();
  List<int> evenNumbers = numbers.where((number) => number.isEven).toList();
  int total = numbers.fold(0, (sum, number) => sum + number);

  print('Original numbers: $numbers');
  print('Doubled numbers: $doubled');
  print('Even numbers: $evenNumbers');
  print('Sum using fold: $total');

  int multiplier = 3;
  int multiply(int value) => value * multiplier;

  print('Closure: 5 * $multiplier = ${multiply(5)}');

  List<String> names = ['Taras', 'Anna', 'Ivan'];
  names.sort();

  print('Sorted names: $names');
}

void demonstrateCalculator() {
  print('\n--- Calculator ---');

  double a = 15;
  double b = 4;

  print('$a + $b = ${add(a, b)}');
  print('$a - $b = ${subtract(a, b)}');
  print('$a * $b = ${multiply(a, b)}');
  print('$a / $b = ${divide(a, b)}');
}

double add(double a, double b) => a + b;

double subtract(double a, double b) => a - b;

double multiply(double a, double b) => a * b;

double divide(double a, double b) {
  if (b == 0) {
    throw ArgumentError('Division by zero is not allowed');
  }

  return a / b;
}

void demonstrateTextAnalyzer() {
  print('\n--- Text Analyzer ---');

  String text =
      'Dart is easy to learn. Dart is useful for Flutter development!';

  List<String> words = text
      .toLowerCase()
      .replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), '')
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .toList();

  Map<String, int> wordCounts = {};

  for (String word in words) {
    wordCounts[word] = (wordCounts[word] ?? 0) + 1;
  }

  print('Text: $text');
  print('Characters including spaces: ${text.length}');
  print('Words: ${words.length}');
  print('Unique words: ${wordCounts.length}');
  print('Word frequency: $wordCounts');
}
