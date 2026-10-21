void main() {
  print('=== Dart Variables & Types Demo ===');

  demonstrateNumbers();
  demonstrateStrings();
  demonstrateBooleans();
  demonstrateCollections();
  demonstrateNullSafety();
}

void demonstrateNumbers() {
  print('\n--- Numbers ---');

  int age = 20;
  double height = 1.78;
  num temperature = 22.5;

  print('Age: $age');
  print('Height: $height');
  print('Temperature: $temperature');
  print('Addition: ${10 + 5}');
  print('Subtraction: ${10 - 5}');
  print('Multiplication: ${10 * 5}');
  print('Division: ${10 / 5}');

  double converted = age.toDouble();
  int rounded = height.round();

  print('Age as double: $converted');
  print('Rounded height: $rounded');
}

void demonstrateStrings() {
  print('\n--- Strings ---');

  String firstName = 'Taras';
  String lastName = 'Kabanets';

  print('Full name: $firstName $lastName');
  print('Uppercase: ${firstName.toUpperCase()}');
  print('Lowercase: ${lastName.toLowerCase()}');
  print('Name length: ${firstName.length}');
  print('Contains "ara": ${firstName.contains('ara')}');

  String message = '''
Dart is a programming language.
It is used for Flutter development.
''';

  print(message);
  print('Escaped text: First line\nSecond line');
}

void demonstrateBooleans() {
  print('\n--- Booleans ---');

  int score = 85;
  bool passed = score >= 60;
  bool excellent = score >= 90;

  print('Score: $score');
  print('Passed: $passed');
  print('Excellent: $excellent');
  print('Passed and excellent: ${passed && excellent}');
  print('Passed or excellent: ${passed || excellent}');
  print('Not passed: ${!passed}');

  String result = passed ? 'Success' : 'Failed';
  print('Result: $result');
}

void demonstrateCollections() {
  print('\n--- Collections ---');

  List<String> subjects = ['Dart', 'Flutter', 'Git'];
  subjects.add('Testing');

  print('Subjects: $subjects');
  print('First subject: ${subjects.first}');
  print('Number of subjects: ${subjects.length}');
  print(
    'Uppercase subjects: '
    '${subjects.map((subject) => subject.toUpperCase()).toList()}',
  );

  List<int> rawNumbers = [1, 2, 2, 3, 4];
  Set<int> numbers = rawNumbers.toSet();
  print('Unique numbers: $numbers');

  Map<String, int> grades = {'Dart': 95, 'Flutter': 88, 'Git': 80};

  print('Grades: $grades');
  print('Dart grade: ${grades['Dart']}');

  List<String> successfulSubjects = grades.entries
      .where((entry) => entry.value >= 85)
      .map((entry) => entry.key)
      .toList();

  print('Subjects with grade >= 85: $successfulSubjects');
}

void demonstrateNullSafety() {
  print('\n--- Null Safety ---');

  String? nickname;
  print('Nickname: ${nickname ?? 'Not specified'}');

  nickname ??= 'Student';
  print('Nickname after assignment: $nickname');

  String? optionalText;
  print('Text length: ${getTextLength(optionalText)}');

  late String university;
  university = 'University of Technology';
  print('University: $university');

  print('Null-aware example: ${uppercaseOrDefault(null)}');
}

int getTextLength(String? text) {
  return text?.length ?? 0;
}

String uppercaseOrDefault(String? text) {
  return text?.toUpperCase() ?? 'NO NAME';
}
