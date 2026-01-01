import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'sign_up_screen.dart';
import '../../../welcome/presentation/screens/welcome_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/styles/app_typography.dart';
import '../../../../core/constants/app_assets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
            child: Container(
              width: w(374),
              height: h(63),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderLight, width: 1),
                borderRadius: BorderRadius.circular(w(38)),
              ),
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
              padding: EdgeInsets.only(left: w(20)),
              child: Text(
                'Email address',
                style: AppTypography.body.copyWith(
                  fontSize: fs(16),
                  height: 1.081,
                  letterSpacing: 0.05 * fs(16),
                  color: AppColors.textSecondary,
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
              padding: EdgeInsets.only(left: w(20)),
              child: Text(
                'Password',
                style: AppTypography.body.copyWith(
                  fontSize: fs(16),
                  height: 1.081,
                  letterSpacing: 0.05 * fs(16),
                  color: AppColors.textSecondary,
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                  );
                },
                child: Text(
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
