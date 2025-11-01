import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/restaurant_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/restaurant_menu_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/order_tracking_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantProvider()..seed()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Food Delivery AR',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode.system,
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (_) => const SplashScreen(),
              AuthScreen.routeName: (_) => const AuthScreen(),
              HomeScreen.routeName: (_) => const HomeScreen(),
              CartScreen.routeName: (_) => const CartScreen(),
              CheckoutScreen.routeName: (_) => const CheckoutScreen(),
              ProfileScreen.routeName: (_) => const ProfileScreen(),
              SettingsScreen.routeName: (_) => const SettingsScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == RestaurantMenuScreen.routeName) {
                final args = settings.arguments as Map<String, dynamic>;
                return MaterialPageRoute(
                  builder: (_) => RestaurantMenuScreen(restaurantId: args['restaurantId'] as String),
                );
              }
              if (settings.name == ProductDetailScreen.routeName) {
                final args = settings.arguments as Map<String, dynamic>;
                return MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(itemId: args['itemId'] as String),
                );
              }
              if (settings.name == OrderTrackingScreen.routeName) {
                final args = settings.arguments as Map<String, dynamic>;
                return MaterialPageRoute(
                  builder: (_) => OrderTrackingScreen(orderId: args['orderId'] as String),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
