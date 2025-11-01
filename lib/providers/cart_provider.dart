import 'package:flutter/foundation.dart';
import '../models/menu_item.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();
  int get count => _items.values.fold(0, (sum, ci) => sum + ci.quantity);
  double get subtotal => _items.values.fold(0.0, (sum, ci) => sum + ci.totalPrice);
  double get deliveryFee => items.isEmpty ? 0 : 2.99;
  double get total => subtotal + deliveryFee;

  void add(MenuItem item) {
    final existing = _items[item.id];
    if (existing != null) {
      existing.quantity += 1;
    } else {
      _items[item.id] = CartItem(item: item, quantity: 1);
    }
    notifyListeners();
  }

  void removeOne(String itemId) {
    final existing = _items[itemId];
    if (existing == null) return;
    if (existing.quantity > 1) {
      existing.quantity -= 1;
    } else {
      _items.remove(itemId);
    }
    notifyListeners();
  }

  void removeAll(String itemId) {
    _items.remove(itemId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
