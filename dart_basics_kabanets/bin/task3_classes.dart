import 'package:dart_basics_kabanets/models/student.dart';
import 'package:dart_basics_kabanets/models/course.dart';
import 'package:dart_basics_kabanets/models/university.dart';

void main() {
print('======================================');
print(' СИСТЕМА УПРАВЛІННЯ УНІВЕРСИТЕТОМ');
print('======================================\n');

final university = University('Університет інформаційних технологій');

// Створення викладача
final professor = Professor(
id: 'P001',
firstName: 'Олена',
lastName: 'Коваленко',
birthDate: DateTime(1985, 5, 12),
salary: 35000,
);

university.addProfessor(professor);

// Створення курсів
final programming = Course(
id: 'C001',
name: 'Програмування на Dart',
description: 'Основи мови Dart та ООП',
credits: 5,
instructor: professor.fullName,
);

final databases = Course(
id: 'C002',
name: 'Бази даних',
description: 'Робота з базами даних та SQL',
credits: 4,
instructor: professor.fullName,
);

university.addCourse(programming);
university.addCourse(databases);
professor.addCourse(programming);
professor.addCourse(databases);

// Створення студентів
final student1 = Student(
id: 'S001',
firstName: 'Тарас',
lastName: 'Кабанець',
birthDate: DateTime(2005, 3, 15),
);

final student2 = Student(
id: 'S002',
firstName: 'Андрій',
lastName: 'Мельник',
birthDate: DateTime(2004, 8, 20),
);

final student3 = Student(
id: 'S003',
firstName: 'Марія',
lastName: 'Шевченко',
birthDate: DateTime(2005, 11, 2),
);

university.addStudent(student1);
university.addStudent(student2);
university.addStudent(student3);

// Запис студентів на курси та виставлення оцінок
student1
..enrollInCourse(programming.id)
..enrollInCourse(databases.id)
..addGrade(programming.id, 95)
..addGrade(databases.id, 88)
..skills.addAll(['Dart', 'Git', 'SQL']);

student2
..enrollInCourse(programming.id)
..addGrade(programming.id, 78)
..skills.addAll(['Dart', 'HTML']);

student3
..enrollInCourse(databases.id)
..addGrade(databases.id, 92)
..skills.addAll(['SQL', 'Python']);

// Виведення студентів
print('--- СПИСОК СТУДЕНТІВ ---');
for (final student in university.students) {
print(student);
}

// Виведення курсів
print('\n--- СПИСОК КУРСІВ ---');
for (final course in university.courses) {
print(course);
}

// Викладачі
print('\n--- ВИКЛАДАЧІ ---');
for (final teacher in university.professors) {
print(teacher);
}

// Демонстрація наслідування та поліморфізму
print('\n--- ПОЛІМОРФІЗМ ---');
final List<Person> people = [
professor,
];

for (final person in people) {
print('${person.role}: ${person.fullName}, вік: ${person.age}');
}

// Пошук студента
print('\n--- ПОШУК СТУДЕНТА ---');
final found = university.findStudentById('S001');
print(found ?? 'Студента не знайдено');

// Пошук за іменем
print('\n--- ПОШУК ЗА ІМЕНЕМ "МАРІЯ" ---');
for (final student in university.searchStudents('Марія')) {
print(student.fullName);
}

// Студенти конкретного курсу
print('\n--- СТУДЕНТИ КУРСУ C001 ---');
for (final student in university.getStudentsByCourse('C001')) {
print(student.fullName);
}

// Обробка колекцій
print('\n--- УНІКАЛЬНІ НАВИЧКИ ---');
final allSkills = <String>{};
for (final student in university.students) {
allSkills.addAll(student.skills);
}
print(allSkills);

// Статистика університету
print('\n--- СТАТИСТИКА УНІВЕРСИТЕТУ ---');
university.getStatistics().forEach((key, value) {
print('$key: $value');
});

// Звіт про успішність
print('\n--- ЗВІТ ПРО УСПІШНІСТЬ ---');
for (final student in university.students) {
print('${student.fullName}: GPA ${student.gpa.toStringAsFixed(2)}');
}

// Видалення студента
print('\n--- ВИДАЛЕННЯ СТУДЕНТА S003 ---');
final removed = university.removeStudent('S003');
print(removed ? 'Студента видалено' : 'Студента не знайдено');
print('Студентів після видалення: ${university.students.length}');

print('\n======================================');
print(' Демонстрацію завершено!');
print('======================================');
}