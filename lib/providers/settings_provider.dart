import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  double _fontSize = 18.0;
  List<int> _favoriteHymnNumbers = [];

  double get fontSize => _fontSize;
  List<int> get favoriteHymnNumbers => _favoriteHymnNumbers;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('font_size') ?? 18.0;
    _favoriteHymnNumbers = prefs.getStringList('favorites')?.map(int.parse).toList() ?? [];
    notifyListeners();
  }

  Future<void> setFontSize(double size) async {
    _fontSize = size;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('font_size', size);
  }

  bool isFavorite(int hymnNumber) => _favoriteHymnNumbers.contains(hymnNumber);

  Future<void> toggleFavorite(int hymnNumber) async {
    if (_favoriteHymnNumbers.contains(hymnNumber)) {
      _favoriteHymnNumbers.remove(hymnNumber);
    } else {
      _favoriteHymnNumbers.add(hymnNumber);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favoriteHymnNumbers.map((e) => e.toString()).toList());
  }
}