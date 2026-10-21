import 'dart:async';

import 'package:flutter/foundation.dart';

class AuthModel extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future<void>.delayed(
      Duration(milliseconds: 1000 + DateTime.now().millisecond % 1001),
    );

    final success =
        email.trim().toLowerCase() == 'student@example.com' &&
        password == 'flutter123';

    _isLoading = false;

    if (success) {
      _isLoggedIn = true;
      _errorMessage = null;
    } else {
      _errorMessage = 'Невірний email або пароль';
    }

    notifyListeners();
    return success;
  }

  void logout() {
    _isLoggedIn = false;
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
