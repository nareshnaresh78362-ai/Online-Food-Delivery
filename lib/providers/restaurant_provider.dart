import 'package:flutter/foundation.dart';
import '../models/restaurant.dart';
import '../models/menu_item.dart';

class RestaurantProvider extends ChangeNotifier {
  final List<Restaurant> _restaurants = [];
  final List<MenuItem> _menuItems = [];

  List<Restaurant> get restaurants => List.unmodifiable(_restaurants);
  List<MenuItem> menuFor(String restaurantId) =>
      _menuItems.where((m) => m.restaurantId == restaurantId).toList();

  MenuItem? itemById(String id) {
    for (final m in _menuItems) {
      if (m.id == id) return m;
    }
    return null;
  }

  Restaurant? byId(String id) {
    for (final r in _restaurants) {
      if (r.id == id) return r;
    }
    return null;
  }

  void seed() {
    if (_restaurants.isNotEmpty) return;
    _restaurants.addAll([
      Restaurant(
        id: 'r1',
        name: 'Burger Town',
        imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=1200',
        rating: 4.6,
        categories: ['Burgers', 'Fast Food'],
        deliveryTimeMin: 25,
        deliveryFee: 1.99,
      ),
      Restaurant(
        id: 'r2',
        name: 'Pasta Palace',
        imageUrl: 'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=1200',
        rating: 4.7,
        categories: ['Italian', 'Pasta'],
        deliveryTimeMin: 30,
        deliveryFee: 2.49,
      ),
    ]);

    _menuItems.addAll([
      MenuItem(
        id: 'm1',
        restaurantId: 'r1',
        name: 'Classic Burger',
        description: 'Juicy beef patty with lettuce, tomato and cheese.',
        price: 6.99,
        imageUrl: 'https://images.unsplash.com/photo-1551782450-17144c3a80e4?w=1200',
        glbUrl: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
        usdzUrl: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
      ),
      MenuItem(
        id: 'm2',
        restaurantId: 'r1',
        name: 'Chicken Burger',
        description: 'Crispy chicken fillet with mayo and pickles.',
        price: 7.49,
        imageUrl: 'https://images.unsplash.com/photo-1606756790138-261faa2bde96?w=1200',
        glbUrl: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
        usdzUrl: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
      ),
      MenuItem(
        id: 'm3',
        restaurantId: 'r2',
        name: 'Creamy Alfredo',
        description: 'Rich and creamy Alfredo pasta with parmesan.',
        price: 9.99,
        imageUrl: 'https://images.unsplash.com/photo-1525755662778-989d0524087e?w=1200',
        glbUrl: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
        usdzUrl: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
      ),
    ]);
  }
}
