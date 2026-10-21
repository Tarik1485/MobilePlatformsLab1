import 'package:flutter/foundation.dart';

class ProfileModel extends ChangeNotifier {
  String _name = 'Студент';
  final String _email = 'student@example.com';
  String _about = 'Користувач застосунку Provider Auth';

  String get name => _name;
  String get email => _email;
  String get about => _about;

  void updateProfile({
    required String name,
    required String about,
  }) {
    _name = name.trim();
    _about = about.trim();
    notifyListeners();
  }
}