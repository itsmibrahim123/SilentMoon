// inside auth_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  bool _isLoading = true; // Start as true to show spinner initially
  bool get isLoading => _isLoading;

  dynamic _user; // Replace 'dynamic' with your actual User model
  dynamic get user => _user;

  // This is the function the Wrapper will call
  Future<void> checkSecureStorageForLogin() async {
    try {
      _isLoading = true;
      notifyListeners();

      // 1. Read from Secure Storage
      String? storedToken = await _storage.read(
        key: 'auth_token',
      ); // or 'isLoggedIn'

      // 2. Validate logic (Customize this based on your needs)
      if (storedToken != null && storedToken.isNotEmpty) {
        // OPTIONAL: Validate token with API here if needed

        // Simulating setting the user (Replace with actual user restoration)
        _user = "User is valid";
      } else {
        _user = null;
      }
    } catch (e) {
      _user = null;
    } finally {
      // 3. Stop loading and update UI
      _isLoading = false;
      notifyListeners();
    }
  }
}
