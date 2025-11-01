import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            value: theme.brightness == Brightness.dark,
            onChanged: (_) {
              // In a real app, wire up theme switching via state
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Theme follows system settings')));
            },
            title: const Text('Dark Mode'),
            subtitle: const Text('Uses system theme by default'),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            subtitle: Text('Online Food Delivery with AR preview'),
          ),
        ],
      ),
    );
  }
}
