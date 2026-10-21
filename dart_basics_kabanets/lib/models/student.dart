class Student {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final List<String> enrolledCourses;
  final Map<String, double> grades;
  final Set<String> skills;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    List<String>? enrolledCourses,
    Map<String, double>? grades,
    Set<String>? skills,
  })  : enrolledCourses = enrolledCourses ?? [],
        grades = grades ?? {},
        skills = skills ?? {};

  String get fullName => '$firstName $lastName';

  int get age {
    final today = DateTime.now();
    int result = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month &&
            today.day < birthDate.day)) {
      result--;
    }

    return result;
  }

  double get gpa {
    if (grades.isEmpty) return 0;

    final average =
        grades.values.reduce((a, b) => a + b) / grades.length;

    return double.parse((average / 20).toStringAsFixed(2));
  }

  void enrollInCourse(String courseId) {
    if (!enrolledCourses.contains(courseId)) {
      enrolledCourses.add(courseId);
    }
  }

  void addGrade(String courseId, double grade) {
    if (grade < 0 || grade > 100) {
      throw ArgumentError('Grade must be between 0 and 100');
    }

    enrollInCourse(courseId);
    grades[courseId] = grade;
  }

  List<String> getPassedCourses() {
    return grades.entries
        .where((entry) => entry.value >= 60)
        .map((entry) => entry.key)
        .toList();
  }

  @override
  String toString() {
    return 'Student(id: $id, name: $fullName, age: $age, GPA: $gpa)';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate.toIso8601String(),
      'enrolledCourses': enrolledCourses,
      'grades': grades,
      'skills': skills.toList(),
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      enrolledCourses:
          List<String>.from(json['enrolledCourses'] as List? ?? []),
      grades: (json['grades'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(key, (value as num).toDouble()),
      ),
      skills: Set<String>.from(json['skills'] as List? ?? []),
    );
  }
}