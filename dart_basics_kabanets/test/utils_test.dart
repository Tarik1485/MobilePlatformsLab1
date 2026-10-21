import 'package:test/test.dart';
import 'package:dart_basics_kabanets/utils/calculator.dart';
import 'package:dart_basics_kabanets/utils/data_processor.dart';

void main() {
  group('Calculator tests', () {
    final calculator = Calculator();

    test('adds two numbers', () {
      expect(calculator.add(5, 3), 8);
    });

    test('subtracts two numbers', () {
      expect(calculator.subtract(5, 3), 2);
    });

    test('multiplies two numbers', () {
      expect(calculator.multiply(5, 3), 15);
    });

    test('divides two numbers', () {
      expect(calculator.divide(6, 3), 2);
    });

    test('throws an error when dividing by zero', () {
      expect(() => calculator.divide(10, 0), throwsArgumentError);
    });

    test('calculates power', () {
      expect(calculator.power(2, 3), 8);
    });
  });

  group('DataProcessor tests', () {
    test('filters even numbers', () {
      expect(
        DataProcessor.filterEvenNumbers([1, 2, 3, 4, 5, 6]),
        [2, 4, 6],
      );
    });

    test('sums numbers', () {
      expect(DataProcessor.sumNumbers([1, 2, 3, 4]), 10);
    });

    test('calculates average', () {
      expect(DataProcessor.calculateAverage([2, 4, 6]), 4);
    });

    test('counts words', () {
      expect(DataProcessor.countWords('Dart is very useful'), {'dart': 1, 'is': 1, 'very': 1, 'useful': 1});
    });
  });
}

