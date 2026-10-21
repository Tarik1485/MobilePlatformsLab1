import '../models/student.dart';
import '../models/course.dart';

class DataProcessor {
static List<int> filterEvenNumbers(List<int> numbers) {
return numbers.where((number) => number.isEven).toList();
}

static int sumNumbers(List<int> numbers) {
return numbers.fold(0, (sum, number) => sum + number);
}

static double calculateAverage(List<num> numbers) {
if (numbers.isEmpty) return 0;

final sum = numbers.fold<num>(0, (total, number) => total + number);
return sum / numbers.length;

}

static Map<String, int> countWords(String text) {
final words = text
.toLowerCase()
.split(RegExp(r'[^a-zA-Zа-яА-ЯіІїЇєЄґҐ0-9]+'))
.where((word) => word.isNotEmpty);

final result = <String, int>{};

for (final word in words) {
  result[word] = (result[word] ?? 0) + 1;
}

return result;

}

static List<Student> sortStudentsByGPA(List<Student> students) {
final result = List<Student>.from(students);
result.sort((a, b) => b.gpa.compareTo(a.gpa));
return result;
}

static Set<String> getUniqueSkills(List<Student> students) {
return students.expand((student) => student.skills).toSet();
}

static Set<String> findCommonCourses(Student first, Student second) {
return first.enrolledCourses.toSet().intersection(
second.enrolledCourses.toSet(),
);
}

static Map<int, List<Student>> groupStudentsByBirthYear(
List<Student> students,
) {
final result = <int, List<Student>>{};

for (final student in students) {
  final year = student.birthDate.year;
  result.putIfAbsent(year, () => []).add(student);
}

return result;

}

static Map<String, double> calculateAverageGradesByCourse(
List<Student> students,
) {
final totals = <String, double>{};
final counts = <String, int>{};

for (final student in students) {
  for (final entry in student.grades.entries) {
    totals[entry.key] = (totals[entry.key] ?? 0) + entry.value;
    counts[entry.key] = (counts[entry.key] ?? 0) + 1;
  }
}

final averages = <String, double>{};

for (final courseId in totals.keys) {
  averages[courseId] = totals[courseId]! / counts[courseId]!;
}

return averages;

}

static String generateStudentReport(List<Student> students) {
if (students.isEmpty) {
return 'Немає даних про студентів.';
}

final sorted = sortStudentsByGPA(students);
final average = calculateAverage(
  students.map((student) => student.gpa).toList(),
);

final buffer = StringBuffer()
  ..writeln('===== ЗВІТ ПРО СТУДЕНТІВ =====')
  ..writeln('Кількість студентів: ${students.length}')
  ..writeln('Середній GPA: ${average.toStringAsFixed(2)}')
  ..writeln('\nРейтинг студентів:');

for (var i = 0; i < sorted.length; i++) {
  buffer.writeln(
    '${i + 1}. ${sorted[i].fullName} — GPA: '
    '${sorted[i].gpa.toStringAsFixed(2)}',
  );
}

return buffer.toString();

}

static List<Course> findCoursesWithoutPrerequisites(
List<Course> courses,
) {
return courses.where((course) => !course.hasPrerequisites()).toList();
}
}