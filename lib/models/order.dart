enum OrderStatus { placed, preparing, outForDelivery, delivered }

class Order {
  final String id;
  final List<OrderLine> lines;
  final double total;
  OrderStatus status;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.lines,
    required this.total,
    required this.status,
    required this.createdAt,
  });
}

class OrderLine {
  final String itemName;
  final int quantity;
  final double price;

  const OrderLine({required this.itemName, required this.quantity, required this.price});
}
