import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../screens/sign_in_sign_up_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().checkSecureStorageForLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the provider for changes (loading status or user updates)
    final auth = context.watch<AuthProvider>();

    // 1. If we are currently checking secure storage, show loading
    if (auth.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Check: Is Firebase User there AND did Storage say we are logged in?
    if (auth.user != null && auth.isSessionValid) {
      return const HomeScreen();
    }
    // 3. Otherwise, show login
    return const SignInSignUpScreen();
  }
}
