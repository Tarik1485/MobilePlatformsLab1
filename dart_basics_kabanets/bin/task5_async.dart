import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<String> loadData() async {
print('Завантаження даних...');
await Future.delayed(const Duration(seconds: 2));
return 'Дані успішно завантажено!';
}

Future<int> calculateAsync(int number) async {
await Future.delayed(const Duration(milliseconds: 500));
return number * number;
}

Stream<int> numberStream(int count) async* {
for (int i = 1; i <= count; i++) {
await Future.delayed(const Duration(milliseconds: 300));
yield i;
}
}

Stream<String> messageStream() async* {
final messages = [
'Ініціалізація...',
'Обробка даних...',
'Збереження результатів...',
'Готово!',
];

for (final message in messages) {
await Future.delayed(const Duration(milliseconds: 400));
yield message;
}
}

Future<void> saveJsonFile(
String filePath,
Map<String, dynamic> data,
) async {
final file = File(filePath);
final jsonString = const JsonEncoder.withIndent('  ').convert(data);
await file.writeAsString(jsonString);
}

Future<Map<String, dynamic>> readJsonFile(String filePath) async {
final file = File(filePath);

if (!await file.exists()) {
throw FileSystemException('Файл не знайдено', filePath);
}

final content = await file.readAsString();
final decoded = jsonDecode(content);

if (decoded is! Map<String, dynamic>) {
throw const FormatException('JSON має бути об’єктом');
}

return decoded;
}

Future<void> demonstrateFuture() async {
print('\n--- 1. FUTURE: АСИНХРОННІ ОПЕРАЦІЇ ---');

final message = await loadData();
print(message);

final results = await Future.wait([
calculateAsync(5),
calculateAsync(7),
calculateAsync(10),
]);

print('Квадрати чисел 5, 7, 10: $results');
}

Future<void> demonstrateStream() async {
print('\n--- 2. STREAM: ПОТІК ЧИСЕЛ ---');

await for (final number in numberStream(5)) {
print('Отримано число: $number');
}

print('\n--- 3. STREAM: ПОТІК ПОВІДОМЛЕНЬ ---');

await for (final message in messageStream()) {
print(message);
}
}

Future<void> demonstrateJson() async {
print('\n--- 4. JSON: ЗБЕРЕЖЕННЯ ТА ЧИТАННЯ ---');

const filePath = 'data.json';

final data = <String, dynamic>{
'university': 'Університет інформаційних технологій',
'subject': 'Програмування для мобільних платформ',
'students': [
{'id': 'S001', 'name': 'Тарас Кабанець', 'score': 95},
{'id': 'S002', 'name': 'Андрій Мельник', 'score': 78},
{'id': 'S003', 'name': 'Марія Шевченко', 'score': 92},
],
'createdAt': DateTime.now().toIso8601String(),
};

await saveJsonFile(filePath, data);
print('Дані збережено у файл $filePath');

final loadedData = await readJsonFile(filePath);
print('Назва університету: ${loadedData['university']}');

final loadedStudents = loadedData['students'] as List<dynamic>;
print('Кількість студентів: ${loadedStudents.length}');

for (final student in loadedStudents) {
print('${student['name']}: ${student['score']} балів');
}
}

Future<void> demonstrateErrorHandling() async {
print('\n--- 5. ОБРОБКА ПОМИЛОК ---');

try {
await readJsonFile('missing_file.json');
} on FileSystemException catch (error) {
print('Очікувана помилка: ${error.message}');
} on FormatException catch (error) {
print('Помилка формату: ${error.message}');
}

try {
final result = await loadData().timeout(
const Duration(milliseconds: 500),
);
print(result);
} on TimeoutException {
print('Операція перевищила ліміт часу.');
}
}

Future<void> main() async {
print('========================================');
print('   АСИНХРОННЕ ПРОГРАМУВАННЯ DART');
print('========================================');

await demonstrateFuture();
await demonstrateStream();
await demonstrateJson();
await demonstrateErrorHandling();

print('\n========================================');
print('   АСИНХРОННУ РОБОТУ ЗАВЕРШЕНО');
print('========================================');
}