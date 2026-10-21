import 'package:flutter/foundation.dart';

class AuthModel extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _readerName = 'Студент';
  String _ticketNumber = 'LIB-2026-001';

  bool get isLoggedIn => _isLoggedIn;
  String get readerName => _readerName;
  String get ticketNumber => _ticketNumber;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 700));

    if (email.trim() == 'student@example.com' &&
        password == 'library123') {
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }

    return false;
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void updateProfile(String name, String ticket) {
    _readerName = name;
    _ticketNumber = ticket;
    notifyListeners();
  }
}