import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String? _email;
  String? _password;

  String? get email => _email;
  String? get password => _password;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  bool validateFields() {
    return _email != null &&
        _password != null &&
        _email!.isNotEmpty &&
        _password!.isNotEmpty;
  }
}
