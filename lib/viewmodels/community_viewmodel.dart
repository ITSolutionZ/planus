import 'package:flutter/material.dart';

class CommunityViewModel extends ChangeNotifier {
  String _searchQuery = '';
  final List<String> _selectedTags = [];

  String get searchQuery => _searchQuery;
  List<String> get selectedTags => _selectedTags;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleTag(String tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    notifyListeners();
  }
}
