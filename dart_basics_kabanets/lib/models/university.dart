import 'student.dart';
import 'course.dart';

abstract class Person {
String get fullName;
int get age;
String get role;

@override
String toString() => '$role: $fullName, age: $age';
}

class Professor extends Person {
final String id;
final String firstName;
final String lastName;
final DateTime birthDate;
final List<Course> courses = [];
final double salary;

Professor({
required this.id,
required this.firstName,
required this.lastName,
required this.birthDate,
this.salary = 0,
});

@override
String get fullName => '$firstName $lastName';

@override
int get age {
final today = DateTime.now();
int result = today.year - birthDate.year;

if (today.month < birthDate.month ||
    (today.month == birthDate.month && today.day < birthDate.day)) {
  result--;
}

return result;

}

@override
String get role => 'Professor';

void addCourse(Course course) {
if (!courses.any((item) => item.id == course.id)) {
courses.add(course);
}
}

@override
String toString() =>
'$role: $fullName, age: $age, courses: ${courses.length}, salary: $salary';
}

class University {
final String name;
final List<Student> students = [];
final List<Course> courses = [];
final List<Professor> professors = [];

University(this.name);

void addStudent(Student student) {
if (!students.any((item) => item.id == student.id)) {
students.add(student);
}
}

bool removeStudent(String id) {
final initialLength = students.length;
students.removeWhere((student) => student.id == id);
return students.length < initialLength;
}

Student? findStudentById(String id) {
for (final student in students) {
if (student.id == id) return student;
}
return null;
}

List<Student> searchStudents(String query) {
final normalized = query.toLowerCase();

return students
    .where((student) => student.fullName.toLowerCase().contains(normalized))
    .toList();

}

void addCourse(Course course) {
if (!courses.any((item) => item.id == course.id)) {
courses.add(course);
}
}

void addProfessor(Professor professor) {
if (!professors.any((item) => item.id == professor.id)) {
professors.add(professor);
}
}

List<Student> getStudentsByCourse(String courseId) {
return students
.where((student) => student.enrolledCourses.contains(courseId))
.toList();
}

List<Course> getAvailableCourses(Student student) {
return courses
.where((course) => course.canStudentEnroll(student))
.toList();
}

Map<String, dynamic> getStatistics() {
final totalGrades = students.fold<int>(
0,
(sum, student) => sum + student.grades.length,
);

final averageGpa = students.isEmpty
    ? 0.0
    : students.fold<double>(
          0,
          (sum, student) => sum + student.gpa,
        ) /
        students.length;

return {
  'university': name,
  'students': students.length,
  'courses': courses.length,
  'professors': professors.length,
  'totalGrades': totalGrades,
  'averageGpa': averageGpa,
};

}
}