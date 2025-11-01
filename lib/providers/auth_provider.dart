import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  AppUser? _user;

  AppUser? get user => _user;
  bool get isLoggedIn => _user != null;

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 700));
    _user = AppUser(id: 'u1', email: email, name: email.split('@').first);
    notifyListeners();
  }

  Future<void> signup(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _user = AppUser(id: 'u1', email: email, name: name);
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
