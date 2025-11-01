import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import 'order_tracking_screen.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = '/checkout';
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _address = TextEditingController();
  final _note = TextEditingController();
  bool _placing = false;

  @override
  void dispose() {
    _address.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    setState(() => _placing = true);
    final cart = context.read<CartProvider>();
    final orderId = await context.read<OrderProvider>().placeOrder(cart);
    cart.clear();
    setState(() => _placing = false);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, OrderTrackingScreen.routeName, arguments: {'orderId': orderId});
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _address, decoration: const InputDecoration(labelText: 'Delivery address', hintText: '123 Main St')), 
            const SizedBox(height: 12),
            TextField(controller: _note, decoration: const InputDecoration(labelText: 'Order notes (optional)')), 
            const Spacer(),
            Row(children: [
              Text('Total', style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              Text('\$${cart.total.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge),
            ]),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _placing ? null : _placeOrder,
                icon: _placing ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.check_circle_outline),
                label: const Text('Place order'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
