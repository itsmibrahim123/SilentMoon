import 'package:flutter/material.dart';
import '../../../meditation/presentation/pages/choose_topic_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/styles/app_typography.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
      body: Stack(
        children: [
          // Welcome background image
          Positioned.fill(
            child: Image.asset(AppAssets.welcomeBg, fit: BoxFit.cover),
          ),

          // GET STARTED button
          Positioned(
            left: w(20),
            top: h(739),
            child: Container(
              width: w(374),
              height: h(63),
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(w(38)),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.borderLight,
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
                      builder: (context) => const ChooseTopicScreen(),
                    ),
                  );
                },
                child: Text(
                  'GET STARTED',
                  style: AppTypography.label.copyWith(
                    fontSize: fs(14),
                    height: 1.081,
                    letterSpacing: 0.05 * fs(14),
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}