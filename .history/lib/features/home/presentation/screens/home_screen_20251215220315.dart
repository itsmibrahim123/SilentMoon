import 'package:flutter/material.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/styles/app_typography.dart';
import 'package:silent_moon/features/welcome/presentation/screens/welcome_sleep_screen.dart';
import '../../../meditation/presentation/screens/meditate_screen.dart';
import '../../../profile/presentation/screens/user_profile_screen.dart';
import '../../../meditation/presentation/screens/course_detail_screen.dart';
import '../../../sleep/presentation/screens/sleep_music_screen.dart';
import 'package:silent_moon/core/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      // Home tab: stay on HomeScreen (no navigation)
      return;
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const WelcomeSleepScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 2) {
      // Navigate to MeditateScreen via PageRouteBuilder (to match animation/behavior)
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const MeditateScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const SleepMusicScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const UserProfileScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // ============================================================
    // 👇 CONFIGURATION SECTION
    // ============================================================

    final double cardWidth = size.width * 0.4261;
    final double tallCardHeight = size.height * 0.2343;
    // ============================================================

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: 20.0,
            top: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Logo and Title ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Silent',
                    style: AppTypography.h2.copyWith(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/images/SilentMoonLogo.png',
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Moon',
                    style: AppTypography.h2.copyWith(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // --- Greeting ---
              Text(
                'Good Morning, Afsar',
                style: AppTypography.h1.copyWith(
                  fontSize: 28,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'We Wish you have a good day',
                style: AppTypography.body.copyWith(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 30),

              // --- Courses Row ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CourseCard(
                    title: 'Basics',
                    subtitle: 'COURSE',
                    duration: '3-10 MIN',
                    color: AppColors.primaryPurple,
                    textColor: AppColors.textWhite,
                    buttonColor: AppColors.textWhite,
                    buttonTextColor: AppColors.textPrimary,
                    imageAsset: AppAssets.basicsCourse,
                    width: cardWidth,
                    height: tallCardHeight,
                    imageRightPadding: 0,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CourseDetailScreen(),
                        ),
                      );
                    },
                  ),
                  CourseCard(
                    title: 'Relaxation',
                    subtitle: 'MUSIC',
                    duration: '3-10 MIN',
                    color: AppColors.accentOrange,
                    textColor: AppColors.textPrimary,
                    buttonColor: AppColors.primaryDark,
                    buttonTextColor: AppColors.textWhite,
                    imageAsset: AppAssets.relaxationMusic,
                    width: cardWidth,
                    height: tallCardHeight,
                    imageRightPadding: 20,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CourseDetailScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // --- Daily Thought ---
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage(AppAssets.backgroundImage),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily Thought',
                          style: AppTypography.h2.copyWith(
                            fontSize: 18,
                            color: AppColors.textWhite,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'MEDITATION • 3-10 MIN',
                          style: AppTypography.caption.copyWith(
                            fontSize: 12,
                            color: AppColors.textWhite.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.textWhite,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // --- Recommended ---
              Text(
                'Recomended for you',
                style: AppTypography.h2.copyWith(
                  fontSize: 20,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetailScreen(),
                          ),
                        );
                      },
                      child: RecommendationCard(
                        title: 'Focus',
                        subtitle: 'MEDITATION • 3-10 MIN',
                        color: AppColors.accentGreen,
                        imageAsset: AppAssets.focus,
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetailScreen(),
                          ),
                        );
                      },
                      child: RecommendationCard(
                        title: 'Happiness',
                        subtitle: 'MEDITATION • 3-10 MIN',
                        color: AppColors.accentOrange,
                        imageAsset: AppAssets.happiness,
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetailScreen(),
                          ),
                        );
                      },
                      child: RecommendationCard(
                        title: 'Focus',
                        subtitle: 'MED',
                        color: AppColors.accentGreen,
                        imageAsset: AppAssets.focus,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // 👇 BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        backgroundColor: AppColors.backgroundWhite,
      ),
    );
  }
}

// ... (Rest of your Card classes remain exactly the same) ...
class CourseCard extends StatelessWidget {
  final String title, subtitle, duration, imageAsset;
  final Color color, textColor, buttonColor, buttonTextColor;
  final double width, height, imageRightPadding;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.color,
    required this.textColor,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.imageAsset,
    required this.width,
    required this.height,
    this.imageRightPadding = 20.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: imageRightPadding,
                child: Image.asset(imageAsset, height: 90, fit: BoxFit.contain),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      title,
                      style: AppTypography.h2.copyWith(
                        fontSize: 20,
                        color: textColor,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTypography.caption.copyWith(
                        fontSize: 12,
                        color: textColor.withValues(alpha: 179),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          duration,
                          style: AppTypography.caption.copyWith(
                            fontSize: 12,
                            color: textColor.withValues(alpha: 179),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: onTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            foregroundColor: buttonTextColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'START',
                            style: AppTypography.caption.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final String title, subtitle, imageAsset;
  final Color color;

  const RecommendationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 160,
          height: 120,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(imageAsset, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: AppTypography.h2.copyWith(
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          subtitle,
          style: AppTypography.caption.copyWith(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
