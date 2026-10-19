import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/hymn_model.dart';
import '../models/chorus_model.dart';

class HymnProvider extends ChangeNotifier {
  List<Hymn> _hymns = [];
  List<Chorus> _choruses = [];
  bool _isLoading = true;
  String _searchQuery = '';

  List<Hymn> get hymns => _hymns;
  List<Chorus> get choruses => _choruses;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  HymnProvider() {
    loadHymnData();
  }

  Future<void> loadHymnData() async {
    try {
      final String response = await rootBundle.loadString('assets/hymn_data.json');
      final data = await json.decode(response);

      _hymns = (data['hymns'] as List).map((i) => Hymn.fromJson(i)).toList();
      _choruses = (data['choruses'] as List).map((i) => Chorus.fromJson(i)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print("Error loading JSON: $e");
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query.trim().toLowerCase();
    notifyListeners();
  }

  List<Hymn> get filteredHymns {
    if (_searchQuery.isEmpty) return _hymns;
    return _hymns.where((hymn) {
      final matchNumber = hymn.number.toString() == _searchQuery;
      final matchTitle = hymn.title.toLowerCase().contains(_searchQuery);
      final matchVerses = hymn.verses.any((v) => v.toLowerCase().contains(_searchQuery));
      return matchNumber || matchTitle || matchVerses;
    }).toList();
  }

  List<Hymn> get alphabeticalHymns {
    // Only include hymns that have a valid title
    List<Hymn> sorted = _hymns.where((h) => h.title.trim().isNotEmpty).toList();
    sorted.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    return sorted;
  }
}