import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  final int totalPages; // トータルページ数を超えないように設定
  int _currentPage = 0;

  OnboardingViewModel({required this.totalPages});

  int get currentPage => _currentPage;

// 現在のページを更新
  void updatePage(int pageIndex) {
    if (pageIndex >= 0 && pageIndex < totalPages) {
      _currentPage = pageIndex;
      notifyListeners();
    }
  }

  // 次へ移動
  void nextPage() {
    if (_currentPage < totalPages - 1) {
      _currentPage++;
      notifyListeners();
    }
  }

  // 前に移動
  void previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      notifyListeners();
    }
  }

  //　現在ページの初期化
  void reset() {
    _currentPage = 0;
    notifyListeners();
  }

  // onboarding pageの完了確認
  bool get isLastPage => _currentPage == totalPages - 1;
}
