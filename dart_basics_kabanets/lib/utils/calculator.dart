class Calculator {
double add(double a, double b) => a + b;

double subtract(double a, double b) => a - b;

double multiply(double a, double b) => a * b;

double divide(double a, double b) {
if (b == 0) {
throw ArgumentError('Ділити на нуль не можна!');
}
return a / b;
}

double power(double base, int exponent) {
if (exponent == 0) return 1;

double result = 1;
for (int i = 0; i < exponent.abs(); i++) {
  result *= base;
}

return exponent < 0 ? 1 / result : result;

}

double average(List<num> numbers) {
if (numbers.isEmpty) {
throw ArgumentError('Список чисел не може бути порожнім!');
}

final sum = numbers.fold<num>(0, (total, number) => total + number);
return sum / numbers.length;

}

double percentage(double value, double percent) {
return value * percent / 100;
}
}