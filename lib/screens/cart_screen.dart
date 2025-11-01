import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: cart.items.length,
                    separatorBuilder: (_, __) => const Divider(height: 0),
                    itemBuilder: (context, i) {
                      final ci = cart.items[i];
                      return ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage(ci.item.imageUrl)),
                        title: Text(ci.item.name),
                        subtitle: Text('\$${ci.item.price.toStringAsFixed(2)} each'),
                        trailing: SizedBox(
                          width: 140,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(onPressed: () => cart.removeOne(ci.item.id), icon: const Icon(Icons.remove_circle_outline)),
                              Text('${ci.quantity}'),
                              IconButton(onPressed: () => cart.add(ci.item), icon: const Icon(Icons.add_circle_outline)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(children: [
                        const Text('Subtotal'),
                        const Spacer(),
                        Text('\$${cart.subtotal.toStringAsFixed(2)}'),
                      ]),
                      const SizedBox(height: 6),
                      Row(children: [
                        const Text('Delivery'),
                        const Spacer(),
                        Text('\$${cart.deliveryFee.toStringAsFixed(2)}'),
                      ]),
                      const SizedBox(height: 8),
                      Row(children: [
                        Text('Total', style: Theme.of(context).textTheme.titleMedium),
                        const Spacer(),
                        Text('\$${cart.total.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium),
                      ]),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: cart.items.isEmpty
                              ? null
                              : () => Navigator.pushNamed(context, CheckoutScreen.routeName),
                          child: const Text('Proceed to Checkout'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
