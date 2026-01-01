import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. Added Provider Import

// 2. Added AuthProvider Import
import '../../../authentication/presentation/providers/auth_provider.dart';
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
    // 3. Initialize AuthProvider to access user data
    final auth = context.watch<AuthProvider>();

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    final double cardWidth = w(177);
    final double tallCardHeight = h(210);

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: w(20.0),
            right: w(20.0),
            bottom: h(20.0),
            top: h(10.0),
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
                      fontSize: fs(16),
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(width: w(8)),
                  Image.asset(
                    AppAssets.silentMoonLogo,
                    width: w(32),
                    height: w(32),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: w(8)),
                  Text(
                    'Moon',
                    style: AppTypography.h2.copyWith(
                      fontSize: fs(16),
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h(30)),

              // --- Greeting with Username ---
              Text(
                'Good Morning,',
                style: AppTypography.h1.copyWith(
                  fontSize: fs(28),
                  color: AppColors.textPrimary,
                ),
              ),
              // 4. Display the actual username here
              Text(
                'Welecome ${auth.user?.displayName ?? 'Guest'}',
                style: AppTypography.h1.copyWith(
                  fontSize: fs(28),
                  fontWeight: FontWeight.w500, // Slightly lighter than header
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: h(2)),
              Text(
                'We Wish you have a good day',
                style: AppTypography.body.copyWith(
                  fontSize: fs(16),
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: h(30)),

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
                    w: w,
                    h: h,
                    fs: fs,
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
                    imageRightPadding: w(20),
                    w: w,
                    h: h,
                    fs: fs,
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
              SizedBox(height: h(30)),

              // --- Daily Thought ---
              Container(
                padding: EdgeInsets.all(w(20)),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(w(20)),
                  image: DecorationImage(
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
                            fontSize: fs(18),
                            color: AppColors.textWhite,
                          ),
                        ),
                        SizedBox(height: h(10)),
                        Text(
                          'MEDITATION • 3-10 MIN',
                          style: AppTypography.caption.copyWith(
                            fontSize: fs(12),
                            color: AppColors.textWhite.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: w(40),
                      height: w(40),
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
              SizedBox(height: h(30)),

              // --- Recommended ---
              Text(
                'Recomended for you',
                style: AppTypography.h2.copyWith(
                  fontSize: fs(20),
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: h(20)),
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
                        w: w,
                        h: h,
                        fs: fs,
                      ),
                    ),
                    SizedBox(width: w(15)),
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
                        w: w,
                        h: h,
                        fs: fs,
                      ),
                    ),
                    SizedBox(width: w(15)),
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
                        w: w,
                        h: h,
                        fs: fs,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h(20)),
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

class CourseCard extends StatelessWidget {
  final String title, subtitle, duration, imageAsset;
  final Color color, textColor, buttonColor, buttonTextColor;
  final double width, height, imageRightPadding;
  final VoidCallback? onTap;
  final double Function(double) w;
  final double Function(double) h;
  final double Function(double) fs;

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
    required this.w,
    required this.h,
    required this.fs,
    this.imageRightPadding = 20.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(w(20)),
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(w(20)),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: imageRightPadding,
                child: Image.asset(
                  imageAsset,
                  height: h(90),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(w(20.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      title,
                      style: AppTypography.h2.copyWith(
                        fontSize: fs(20),
                        color: textColor,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTypography.caption.copyWith(
                        fontSize: fs(12),
                        color: textColor.withValues(alpha: 179),
                      ),
                    ),
                    SizedBox(height: h(15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          duration,
                          style: AppTypography.caption.copyWith(
                            fontSize: fs(12),
                            color: textColor.withValues(alpha: 179),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: onTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            foregroundColor: buttonTextColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(w(20)),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: w(12),
                              vertical: h(5),
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'START',
                            style: AppTypography.caption.copyWith(
                              fontSize: fs(11),
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
  final double Function(double) w;
  final double Function(double) h;
  final double Function(double) fs;

  const RecommendationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.imageAsset,
    required this.w,
    required this.h,
    required this.fs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: w(160),
          height: h(120),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(w(20)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(w(20)),
            child: Image.asset(imageAsset, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: h(10)),
        Text(
          title,
          style: AppTypography.h2.copyWith(
            fontSize: fs(16),
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          subtitle,
          style: AppTypography.caption.copyWith(
            fontSize: fs(12),
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
