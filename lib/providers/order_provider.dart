import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/order.dart';
import 'cart_provider.dart';

class OrderProvider extends ChangeNotifier {
  final Map<String, Order> _orders = {};

  List<Order> get orders => _orders.values.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  Future<String> placeOrder(CartProvider cart) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final order = Order(
      id: id,
      lines: cart.items
          .map((ci) => OrderLine(itemName: ci.item.name, quantity: ci.quantity, price: ci.item.price))
          .toList(),
      total: cart.total,
      status: OrderStatus.placed,
      createdAt: DateTime.now(),
    );
    _orders[id] = order;
    notifyListeners();

    // Simulate status updates
    Timer(const Duration(seconds: 3), () {
      _updateStatus(id, OrderStatus.preparing);
    });
    Timer(const Duration(seconds: 7), () {
      _updateStatus(id, OrderStatus.outForDelivery);
    });
    Timer(const Duration(seconds: 12), () {
      _updateStatus(id, OrderStatus.delivered);
    });

    return id;
  }

  Order? byId(String id) => _orders[id];

  void _updateStatus(String id, OrderStatus status) {
    final order = _orders[id];
    if (order == null) return;
    order.status = status;
    notifyListeners();
  }
}
