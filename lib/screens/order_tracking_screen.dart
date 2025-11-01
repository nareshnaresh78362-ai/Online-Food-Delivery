import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';

class OrderTrackingScreen extends StatelessWidget {
  static const routeName = '/order-tracking';
  final String orderId;
  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Tracking')),
      body: Consumer<OrderProvider>(
        builder: (context, op, _) {
          final order = op.byId(orderId);
          if (order == null) {
            return const Center(child: Text('Order not found'));
          }
          final steps = [
            _StepData('Order placed', Icons.receipt_long, OrderStatus.placed),
            _StepData('Preparing', Icons.restaurant, OrderStatus.preparing),
            _StepData('Out for delivery', Icons.delivery_dining, OrderStatus.outForDelivery),
            _StepData('Delivered', Icons.check_circle, OrderStatus.delivered),
          ];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text('Order #${order.id}'),
                    subtitle: Text('Total: \$${order.total.toStringAsFixed(2)}'),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemCount: steps.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final s = steps[i];
                      final active = order.status.index >= s.status.index;
                      return _TrackingTile(label: s.label, icon: s.icon, active: active);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StepData {
  final String label;
  final IconData icon;
  final OrderStatus status;
  const _StepData(this.label, this.icon, this.status);
}

class _TrackingTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;
  const _TrackingTile({required this.label, required this.icon, required this.active});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: active ? cs.primaryContainer : cs.surface,
        border: Border.all(color: active ? cs.primary : cs.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(icon, color: active ? cs.onPrimaryContainer : cs.onSurfaceVariant),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: active ? cs.onPrimaryContainer : null)),
          const Spacer(),
          Icon(active ? Icons.check_circle : Icons.radio_button_unchecked, color: active ? cs.primary : cs.outline)
        ],
      ),
    );
  }
}
