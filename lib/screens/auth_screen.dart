import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);
  final _loginEmail = TextEditingController();
  final _loginPassword = TextEditingController();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmail.dispose();
    _loginPassword.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _doLogin() async {
    setState(() => _loading = true);
    await context.read<AuthProvider>().login(_loginEmail.text, _loginPassword.text);
    setState(() => _loading = false);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  Future<void> _doSignup() async {
    setState(() => _loading = true);
    await context.read<AuthProvider>().signup(_name.text, _email.text, _password.text);
    setState(() => _loading = false);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [Tab(text: 'Login'), Tab(text: 'Sign up')],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _FormWrapper(
                  loading: _loading,
                  onSubmit: _doLogin,
                  children: [
                    TextField(controller: _loginEmail, decoration: const InputDecoration(labelText: 'Email')),
                    const SizedBox(height: 12),
                    TextField(controller: _loginPassword, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
                  ],
                ),
                _FormWrapper(
                  loading: _loading,
                  onSubmit: _doSignup,
                  children: [
                    TextField(controller: _name, decoration: const InputDecoration(labelText: 'Name')),
                    const SizedBox(height: 12),
                    TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
                    const SizedBox(height: 12),
                    TextField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FormWrapper extends StatelessWidget {
  final bool loading;
  final VoidCallback onSubmit;
  final List<Widget> children;
  const _FormWrapper({required this.loading, required this.onSubmit, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 24),
          ...children,
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: loading ? null : onSubmit,
              child: loading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
