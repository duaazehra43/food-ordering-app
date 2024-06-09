import 'package:flutter/foundation.dart';

class FavoritesModel extends ChangeNotifier {
  final List<Map<String, String>> _items = [];

  List<Map<String, String>> get items => _items;

  bool isFavorite(String title) {
    return _items.any((item) => item['title'] == title);
  }

  void toggleFavorite(Map<String, String> item) {
    if (isFavorite(item['title']!)) {
      _items.removeWhere((element) => element['title'] == item['title']);
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(Map<String, String> item) {
    _items.removeWhere((element) => element['title'] == item['title']);
    notifyListeners();
  }
}
