import 'package:dart_basics_kabanets/models/student.dart';
import 'package:dart_basics_kabanets/utils/data_processor.dart';
import 'dart:io';

void main() {
print('========================================');
print('   РОБОТА З КОЛЕКЦІЯМИ DART');
print('========================================');

// 1. LIST — списки
print('\n--- 1. LIST: СПИСКИ ---');

final List<int> numbers = [15, 8, 23, 4, 16, 7, 42, 10, 8, 15];

print('Початковий список: $numbers');
print('Парні числа: ${DataProcessor.filterEvenNumbers(numbers)}');

final sortedNumbers = List<int>.from(numbers)..sort();
print('Відсортований список: $sortedNumbers');

print('Сума чисел: ${DataProcessor.sumNumbers(numbers)}');
print(
'Середнє значення: '
'${DataProcessor.calculateAverage(numbers).toStringAsFixed(2)}',
);

final uniqueNumbers = numbers.toSet().toList()..sort();
print('Унікальні числа: $uniqueNumbers');

// 2. SET — множини
print('\n--- 2. SET: МНОЖИНИ ---');

final Set<String> programmingLanguages = {
'Dart',
'Java',
'Python',
'C++',
};

final Set<String> popularLanguages = {
'Dart',
'Python',
'JavaScript',
};

print('Мови програмування: $programmingLanguages');
print('Популярні мови: $popularLanguages');
print(
'Спільні мови: '
'${programmingLanguages.intersection(popularLanguages)}',
);
print(
'Усі мови без повторів: '
'${programmingLanguages.union(popularLanguages)}',
);
print(
'Мови лише з першої множини: '
'${programmingLanguages.difference(popularLanguages)}',
);

// 3. MAP — словники
print('\n--- 3. MAP: СЛОВНИКИ ---');

final Map<String, int> studentScores = {
'Тарас': 95,
'Андрій': 78,
'Марія': 92,
'Олена': 84,
};

print('Оцінки студентів:');
studentScores.forEach((name, score) {
print('$name: $score балів');
});

final bestStudent = studentScores.entries.reduce(
(a, b) => a.value >= b.value ? a : b,
);

print('Найкращий результат: ${bestStudent.key} (${bestStudent.value})');

final averageScore = studentScores.values.reduce((a, b) => a + b) /
studentScores.length;

print('Середній бал: ${averageScore.toStringAsFixed(2)}');

// 4. Підрахунок слів у тексті
print('\n--- 4. АНАЛІЗ ТЕКСТУ ---');

const text =
'Dart is useful. Dart is modern. Programming with Dart is fun.';

print('Текст: $text');
print('Кількість кожного слова: ${DataProcessor.countWords(text)}');

// 5. Робота зі студентами
print('\n--- 5. ОБРОБКА ДАНИХ СТУДЕНТІВ ---');

final students = [
Student(
id: 'S001',
firstName: 'Тарас',
lastName: 'Кабанець',
birthDate: DateTime(2005, 3, 15),
),
Student(
id: 'S002',
firstName: 'Андрій',
lastName: 'Мельник',
birthDate: DateTime(2004, 8, 20),
),
Student(
id: 'S003',
firstName: 'Марія',
lastName: 'Шевченко',
birthDate: DateTime(2005, 11, 2),
),
];

students[0]
..addGrade('C001', 95)
..addGrade('C002', 88)
..skills.addAll(['Dart', 'Git', 'SQL']);

students[1]
..addGrade('C001', 78)
..skills.addAll(['Dart', 'HTML']);

students[2]
..addGrade('C002', 92)
..skills.addAll(['SQL', 'Python']);

print('\nСтуденти, відсортовані за GPA:');
for (final student in DataProcessor.sortStudentsByGPA(students)) {
print('${student.fullName}: GPA ${student.gpa.toStringAsFixed(2)}');
}

print('\nУнікальні навички: ${DataProcessor.getUniqueSkills(students)}');

print('\nГрупування за роком народження:');
final grouped = DataProcessor.groupStudentsByBirthYear(students);

grouped.forEach((year, group) {
print('$year: ${group.map((student) => student.fullName).join(', ')}');
});

print('\nСередні оцінки за курсами:');
print(DataProcessor.calculateAverageGradesByCourse(students));

print('\n${DataProcessor.generateStudentReport(students)}');

// 6. CSV — створення та аналіз файлу
print('\n--- 6. АНАЛІЗ CSV-ФАЙЛУ ---');

final csvFile = File('students.csv');

const csvContent = '''name,course,score
Тарас,Dart,95
Андрій,Dart,78
Марія,SQL,92
Олена,SQL,84
Іван,Dart,88''';

csvFile.writeAsStringSync(csvContent);

final lines = csvFile.readAsLinesSync();
print('Файл: ${csvFile.path}');
print('Кількість записів: ${lines.length - 1}');

final courseTotals = <String, int>{};
final courseCounts = <String, int>{};

for (final line in lines.skip(1)) {
final columns = line.split(',');
if (columns.length != 3) continue;

final course = columns[1];
final score = int.tryParse(columns[2]);

if (score == null) continue;

courseTotals[course] = (courseTotals[course] ?? 0) + score;
courseCounts[course] = (courseCounts[course] ?? 0) + 1;

}

print('Середній бал за курсами:');
courseTotals.forEach((course, total) {
final average = total / courseCounts[course]!;
print('$course: ${average.toStringAsFixed(2)}');
});

print('\n========================================');
print('   РОБОТУ З КОЛЕКЦІЯМИ ЗАВЕРШЕНО');
print('========================================');
}