import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void updatePage(int pageIndex) {
    _currentPage = pageIndex;
    notifyListeners();
  }
}
