import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 36, child: Text(auth.user?.name.substring(0, 1).toUpperCase() ?? 'U')),
            const SizedBox(height: 12),
            Text(auth.user?.name ?? 'User', style: Theme.of(context).textTheme.titleLarge),
            Text(auth.user?.email ?? ''),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  auth.logout();
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                icon: const Icon(Icons.logout),
                label: const Text('Log out'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
