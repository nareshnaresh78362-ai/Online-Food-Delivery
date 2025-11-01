import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product';
  final String itemId;
  const ProductDetailScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    final rp = context.watch<RestaurantProvider>();
    final item = rp.itemById(itemId);
    if (item == null) {
      return const Scaffold(body: Center(child: Text('Item not found')));
    }
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(item.name), actions: [
        IconButton(onPressed: () => context.read<CartProvider>().add(item), icon: const Icon(Icons.add_shopping_cart))
      ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 320,
              child: ModelViewer(
                src: item.glbUrl,
                iosSrc: item.usdzUrl,
                alt: '3D view of ${item.name}',
                autoRotate: true,
                cameraControls: true,
                ar: true,
                arModes: const ['scene-viewer', 'quick-look', 'webxr'],
                disableZoom: false,
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(item.description),
                  const SizedBox(height: 16),
                  Row(children: [
                    Text('\$${item.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: cs.primary)),
                    const Spacer(),
                    FilledButton.icon(
                      onPressed: () => context.read<CartProvider>().add(item),
                      icon: const Icon(Icons.add),
                      label: const Text('Add to cart'),
                    ),
                  ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
