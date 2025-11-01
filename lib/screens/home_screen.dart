import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_button.dart';
import 'restaurant_menu_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final restaurants = context.watch<RestaurantProvider>().restaurants.where((r) {
      return _query.isEmpty || r.name.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Restaurants'),
        actions: const [CartButton()],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search restaurants'),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.78,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final r = restaurants[index];
                return _RestaurantCard(
                  name: r.name,
                  image: r.imageUrl,
                  rating: r.rating,
                  time: r.deliveryTimeMin,
                  onTap: () => Navigator.pushNamed(context, RestaurantMenuScreen.routeName, arguments: {'restaurantId': r.id}),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
        onTap: (i) {
          if (i == 1) Navigator.pushNamed(context, '/profile');
          if (i == 2) Navigator.pushNamed(context, '/settings');
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/cart'),
        icon: const Icon(Icons.shopping_bag_outlined),
        label: Consumer<CartProvider>(builder: (context, cart, _) => Text('Cart (${cart.count})')),
      ),
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  final String name;
  final String image;
  final double rating;
  final int time;
  final VoidCallback onTap;
  const _RestaurantCard({required this.name, required this.image, required this.rating, required this.time, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
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
                child: Image.network(image, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Row(children: [
                  Icon(Icons.star_rounded, color: Colors.amber[600], size: 18),
                  const SizedBox(width: 4),
                  Text(rating.toStringAsFixed(1)),
                  const Spacer(),
                  const Icon(Icons.schedule, size: 16),
                  const SizedBox(width: 4),
                  Text('$time min'),
                ])
              ]),
            )
          ],
        ),
      ),
    );
  }
}
