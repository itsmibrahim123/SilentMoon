import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'sign_up_screen.dart';
import '../../../welcome/presentation/pages/welcome_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/styles/app_typography.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/storage_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLastEmail();
  }

  Future<void> _loadLastEmail() async {
    try {
      final email = StorageService.instance.getString('last_email');
      if (email != null && mounted) {
        _emailController.text = email;
      }
    } catch (_) {
      // Storage not initialized or unavailable; ignore.
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // FIXED: Removed (BuildContext context) argument
  Future<void> _handleSignIn() async {
    // context is now accessed directly from the State class
    final auth = context.read<AuthProvider>();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    final success = await auth.signIn(email: email, password: password);

    // This check now correctly protects 'this.context'
    if (!mounted) return;

    if (!success) {
      final message = auth.errorMessage ?? 'Failed to sign in';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    }
  }

  // FIXED: Removed (BuildContext context) argument
  Future<void> _handleGoogleSignIn() async {
    final auth = context.read<AuthProvider>();

    final success = await auth.signInWithGoogle();

    if (!mounted) return;

    if (!success) {
      final message = auth.errorMessage ?? 'Failed to sign in with Google';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    // Reference: 414 x 896
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Stack(
        children: [
          // signINBG background
          Positioned(
            left: w(-41.71),
            top: h(-77.77),
            child: Image.asset(
              AppAssets.signInBg,
              width: w(547.19),
              height: h(428.24),
              fit: BoxFit.cover,
            ),
          ),
          // Back button
          Positioned(
            left: w(20.24),
            top: h(50),
            child: Container(
              width: w(55.0),
              height: w(55.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                border: Border.all(color: AppColors.borderLight, width: 1),
                borderRadius: BorderRadius.circular(w(38)),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.textPrimary,
                      size: w(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Welcome Back! text
          Positioned(
            left: w(103),
            top: h(133.47),
            child: SizedBox(
              width: w(208),
              height: h(38),
              child: Text(
                'Welcome Back!',
                style: AppTypography.h1.copyWith(
                  fontSize: fs(28),
                  height: 1.35,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          // Facebook button
          Positioned(
            left: w(20),
            top: h(204.47),
            child: Container(
              width: w(374),
              height: h(63),
              decoration: BoxDecoration(
                color: AppColors.primaryPurple,
                borderRadius: BorderRadius.circular(w(38)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: w(24),
                    top: h(12),
                    child: Image.asset(
                      AppAssets.fbLogo,
                      width: w(39),
                      height: h(39),
                    ),
                  ),
                  Center(
                    child: Text(
                      'CONTINUE WITH FACEBOOK',
                      style: AppTypography.label.copyWith(
                        fontSize: fs(14),
                        height: 1.081,
                        letterSpacing: 0.05 * fs(14),
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Google button
          Positioned(
            left: w(20),
            top: h(287.47),
            child: SizedBox(
              width: w(374),
              height: h(63),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundWhite,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w(38)),
                    side: const BorderSide(
                      color: AppColors.borderLight,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                ),
                // FIXED: Updated call to remove argument
                onPressed: auth.isLoading ? null : _handleGoogleSignIn,
                child: Stack(
                  children: [
                    Positioned(
                      left: w(24),
                      top: h(12),
                      child: Image.asset(
                        AppAssets.googleLogo,
                        width: w(39),
                        height: h(39),
                      ),
                    ),
                    Center(
                      child: Text(
                        'CONTINUE WITH GOOGLE',
                        style: AppTypography.label.copyWith(
                          fontSize: fs(14),
                          height: 1.081,
                          letterSpacing: 0.05 * fs(14),
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // OR LOG IN WITH EMAIL
          Positioned(
            left: w(112.73),
            top: h(390.47),
            child: SizedBox(
              width: w(188.54),
              height: h(14),
              child: Text(
                'OR LOG IN WITH EMAIL',
                textAlign: TextAlign.center,
                style: AppTypography.labelBold.copyWith(
                  fontSize: fs(14),
                  height: 1.081,
                  letterSpacing: 0.05 * fs(14),
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          // Email address field
          Positioned(
            left: w(20),
            top: h(444.47),
            child: Container(
              width: w(374),
              height: h(63),
              decoration: BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.circular(w(15)),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: w(20)),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: AppTypography.body.copyWith(
                  fontSize: fs(16),
                  height: 1.081,
                  letterSpacing: 0.05 * fs(16),
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email address',
                  hintStyle: AppTypography.body.copyWith(
                    fontSize: fs(16),
                    height: 1.081,
                    letterSpacing: 0.05 * fs(16),
                    color: AppColors.textSecondary,
                  ),
                  isCollapsed: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          // Password field
          Positioned(
            left: w(20),
            top: h(527.47),
            child: Container(
              width: w(374),
              height: h(63),
              decoration: BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.circular(w(15)),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: w(20)),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                style: AppTypography.body.copyWith(
                  fontSize: fs(16),
                  height: 1.081,
                  letterSpacing: 0.05 * fs(16),
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                  hintStyle: AppTypography.body.copyWith(
                    fontSize: fs(16),
                    height: 1.081,
                    letterSpacing: 0.05 * fs(16),
                    color: AppColors.textSecondary,
                  ),
                  isCollapsed: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          // LOG IN button
          Positioned(
            left: w(20),
            top: h(620.47),
            child: Container(
              width: w(374),
              height: h(63),
              decoration: BoxDecoration(
                color: AppColors.primaryPurple,
                borderRadius: BorderRadius.circular(w(38)),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w(38)),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                ),
                // FIXED: Updated call to remove argument
                onPressed: auth.isLoading ? null : _handleSignIn,
                child: auth.isLoading
                    ? SizedBox(
                        width: w(24),
                        height: w(24),
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.textWhite,
                          ),
                        ),
                      )
                    : Text(
                        'LOG IN',
                        style: AppTypography.label.copyWith(
                          fontSize: fs(14),
                          height: 1.081,
                          letterSpacing: 0.05 * fs(14),
                          color: AppColors.textWhite,
                        ),
                      ),
              ),
            ),
          ),
          // Forgot Password?
          Positioned(
            left: w(139.73),
            top: h(703.47),
            child: SizedBox(
              width: w(134.54),
              height: h(14),
              child: Text(
                'Forgot Password?',
                textAlign: TextAlign.center,
                style: AppTypography.label.copyWith(
                  fontSize: fs(14),
                  height: 1.081,
                  letterSpacing: 0.05 * fs(14),
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          // ALREADY HAVE AN ACCOUNT? SIGN UP
          Positioned(
            left: w(60.45),
            top: h(822),
            child: SizedBox(
              width: w(293.1),
              height: h(14),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTypography.label.copyWith(
                    fontSize: fs(14),
                    height: 1.081,
                    letterSpacing: 0.05 * fs(14),
                    color: AppColors.textSecondary,
                  ),
                  children: [
                    const TextSpan(text: 'ALREADY HAVE AN ACCOUNT? '),
                    TextSpan(
                      text: 'SIGN UP',
                      style: AppTypography.label.copyWith(
                        color: AppColors.primaryPurple,
                        fontSize: fs(14),
                        height: 1.081,
                        letterSpacing: 0.05 * fs(14),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          // Line 2 (bottom indicator)
          Positioned(
            left: w(136),
            top: h(882),
            child: Container(
              width: w(143),
              height: h(5),
              decoration: BoxDecoration(
                color: AppColors.borderGrey,
                borderRadius: BorderRadius.circular(w(2.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
