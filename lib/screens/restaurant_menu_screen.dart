import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_button.dart';
import '../models/menu_item.dart';
import 'product_detail_screen.dart';

class RestaurantMenuScreen extends StatelessWidget {
  static const routeName = '/restaurant';
  final String restaurantId;
  const RestaurantMenuScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    final rp = context.watch<RestaurantProvider>();
    final r = rp.byId(restaurantId);
    final menu = rp.menuFor(restaurantId);
    return Scaffold(
      appBar: AppBar(
        title: Text(r?.name ?? 'Menu'),
        actions: const [CartButton()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (r != null)
            _RestaurantHeader(
              image: r.imageUrl,
              rating: r.rating,
              categories: r.categories.join(' • '),
              delivery: '${r.deliveryTimeMin} min • \$${r.deliveryFee.toStringAsFixed(2)}',
            ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: menu.length,
              itemBuilder: (context, i) => _MenuCard(item: menu[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _RestaurantHeader extends StatelessWidget {
  final String image;
  final double rating;
  final String categories;
  final String delivery;
  const _RestaurantHeader({required this.image, required this.rating, required this.categories, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(image, fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Row(
                children: [
                  Icon(Icons.star_rounded, color: Colors.amber[600]),
                  const SizedBox(width: 4),
                  Text(rating.toStringAsFixed(1), style: const TextStyle(color: Colors.white)),
                  const Spacer(),
                  Text(categories, style: const TextStyle(color: Colors.white)),
                  const SizedBox(width: 12),
                  Text(delivery, style: const TextStyle(color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final MenuItem item;
  const _MenuCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: {'itemId': item.id}),
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: cs.surface, boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3)),
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(item.imageUrl, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Row(children: [
                  Text('\$${item.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add_circle_rounded),
                    onPressed: () => context.read<CartProvider>().add(item),
                  )
                ])
              ]),
            )
          ],
        ),
      ),
    );
  }
}
