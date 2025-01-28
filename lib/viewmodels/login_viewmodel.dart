import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String? _email;
  String? _password;
  String? _emailError;
  String? _passwordError;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoading => _isLoading;

  void setEmail(String email) {
    _email = email;
    _emailError = null;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    _passwordError = null;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  bool validateFields() {
    bool isValid = true;
    if (_email == null || _email!.isEmpty) {
      _emailError = 'メールを入力してください。';
      isValid = false;
    } else if (!_email!.contains('@')) {
      _emailError = '有効なメールアドレスを入力してください。';
      isValid = false;
    }

    if (_password == null || _password!.isEmpty) {
      _passwordError = 'パスワードを入力してください。';
      isValid = false;
    } else if (_password!.length < 6) {
      _passwordError = 'パスワードは6文字以上必要です。';
      isValid = false;
    }

    notifyListeners();
    return isValid;
  }

  Future<bool> login() async {
    if (!validateFields()) return false;

    _isLoading = true;
    notifyListeners();

    // ネットワークリクエストの代わりに時間を遅らせる（dummy）
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();

    // ログイン成功 現在は強引成功としている。
    return true;
  }
}
