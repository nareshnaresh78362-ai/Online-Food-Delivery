import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'auth_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      final isLoggedIn = context.read<AuthProvider>().isLoggedIn;
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, isLoggedIn ? HomeScreen.routeName : AuthScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [cs.primary, cs.tertiary], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.fastfood_rounded, size: 88, color: cs.onPrimary),
              const SizedBox(height: 12),
              Text('Food Delivery AR', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: cs.onPrimary)),
              const SizedBox(height: 24),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
