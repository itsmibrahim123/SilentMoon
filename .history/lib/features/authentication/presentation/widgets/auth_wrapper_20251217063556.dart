import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../screens/sign_in_sign_up_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';

/// Presentation-layer widget that decides which screen to show
/// based on the current authentication state.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (auth.isLoading && auth.user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (auth.user == null) {
      return const SignInSignUpScreen();
    }

    return const HomeScreen();
  }
}
