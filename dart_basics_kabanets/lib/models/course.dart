import 'student.dart';

class Course {
  final String id;
  final String name;
  final String description;
  final int credits;
  final String instructor;
  final List<String> prerequisites;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.credits,
    required this.instructor,
    List<String>? prerequisites,
  }) : prerequisites = prerequisites ?? [];

  bool hasPrerequisites() {
    return prerequisites.isNotEmpty;
  }

  bool canStudentEnroll(Student student) {
    return prerequisites.every(
      (courseId) =>
          student.grades.containsKey(courseId) &&
          student.grades[courseId]! >= 60,
    );
  }

  @override
  String toString() {
    return 'Course(id: $id, name: $name, credits: $credits, '
        'instructor: $instructor, prerequisites: $prerequisites)';
  }
}
