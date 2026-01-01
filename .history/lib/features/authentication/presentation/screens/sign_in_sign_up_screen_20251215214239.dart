// This is the entry point for the Sign In and Sign Up screen.
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/styles/app_typography.dart';

class SignInSignUpScreen extends StatelessWidget {
  const SignInSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    // Reference: 414 x 896
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Stack(
        children: [
          // Beige background image
          Positioned(
            left: w(-3),
            top: 0,
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                AppAssets.beigeBg,
                width: w(423),
                height: h(504),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Sofa girl image
          Positioned(
            left: w(40.69),
            top: h(160),
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'assets/images/sofaGirl.png',
                width: w(332.22),
                height: h(242.69),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Logo
          Positioned(
            left: w(123),
            top: h(50),
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'assets/images/logo.png',
                width: w(168),
                height: h(30),
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Text box container
          Positioned(
            left: w(58),
            top: h(534),
            width: w(298),
            child: Column(
              children: [
                // First row - "We are what we do"
                SizedBox(
                  width: w(300),
                  child: Text(
                    'We are what we do',
                    textAlign: TextAlign.center,
                    style: AppTypography.h1.copyWith(
                      fontSize: fs(30),
                      height: 1.35,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(height: h(15)),
                // Second row - description text
                SizedBox(
                  width: w(298),
                  child: Text(
                    'Thousand of people are using silent moon for smalls meditation',
                    textAlign: TextAlign.center,
                    style: AppTypography.body.copyWith(
                      fontSize: fs(16),
                      height: 1.65,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom container
          Positioned(
            left: w(20),
            top: h(705),
            width: w(374),
            child: Column(
              children: [
                // Sign Up button
                SizedBox(
                  width: w(374),
                  height: h(63),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w(38)),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'SIGN UP',
                      style: AppTypography.label.copyWith(
                        fontSize: fs(14),
                        height: 1.08,
                        letterSpacing: 0.7,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h(20)),
                // Already have an account text with LOG IN
                SizedBox(
                  width: w(282),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTypography.label.copyWith(
                        fontSize: fs(14),
                        height: 1.08,
                        letterSpacing: 0.7,
                        color: AppColors.textPrimary,
                      ),
                      children: [
                        const TextSpan(text: 'ALREADY HAVE AN ACCOUNT? '),
                        TextSpan(
                          text: 'LOG IN',
                          style: AppTypography.label.copyWith(
                            color: AppColors.primaryPurple,
                            fontSize: fs(14),
                            height: 1.08,
                            letterSpacing: 0.7,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignInScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
