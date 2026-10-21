import 'package:test/test.dart';
import 'package:dart_basics_kabanets/models/student.dart';
import 'package:dart_basics_kabanets/models/course.dart';
import 'package:dart_basics_kabanets/models/university.dart';

void main() {
  group('Student tests', () {
    late Student student;

    setUp(() {
      student = Student(
        id: 'S001',
        firstName: 'Taras',
        lastName: 'Kabanets',
        birthDate: DateTime(2005, 3, 15),
      );
    });

    test('fullName returns first and last name', () {
      expect(student.fullName, 'Taras Kabanets');
    });

    test('enrollInCourse adds a course', () {
      student.enrollInCourse('C001');
      expect(student.enrolledCourses, contains('C001'));
    });

    test('addGrade stores a grade', () {
      student.addGrade('C001', 95);
      expect(student.grades['C001'], 95);
    });

    test('skills can be added', () {
      student.skills.add('Dart');
      expect(student.skills, contains('Dart'));
    });
  });

  group('Course tests', () {
    test('course stores its properties', () {
      final course = Course(
        id: 'C001',
        name: 'Dart',
        description: 'Dart basics',
        credits: 5,
        instructor: 'Olena Kovalenko',
      );

      expect(course.id, 'C001');
      expect(course.name, 'Dart');
      expect(course.credits, 5);
    });
  });

  group('University tests', () {
    test('adds and finds a student', () {
      final university = University('Test University');
      final student = Student(
        id: 'S001',
        firstName: 'Taras',
        lastName: 'Kabanets',
        birthDate: DateTime(2005, 3, 15),
      );

      university.addStudent(student);

      expect(university.students.length, 1);
      expect(university.findStudentById('S001'), same(student));
    });

    test('removes a student', () {
      final university = University('Test University');
      final student = Student(
        id: 'S001',
        firstName: 'Taras',
        lastName: 'Kabanets',
        birthDate: DateTime(2005, 3, 15),
      );

      university.addStudent(student);

      expect(university.removeStudent('S001'), isTrue);
      expect(university.students, isEmpty);
    });
  });
}
