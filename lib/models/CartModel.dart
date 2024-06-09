import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, String>> _items = [];

  List<Map<String, String>> get items => _items;

  void addItem(Map<String, String> item) {
    _items.add(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double get totalAmount {
    double total = 0;
    for (var item in _items) {
      total += double.parse(item['price']!.substring(1));
    }
    return total;
  }
}
