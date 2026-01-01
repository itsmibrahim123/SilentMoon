import 'package:flutter/material.dart';
import 'package:silent_moon/core/widgets/bottom_nav_bar.dart';
import 'package:silent_moon/core/styles/app_colors.dart';
import 'package:silent_moon/core/styles/app_typography.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../../../sleep/presentation/pages/sleep_music_screen.dart';
import '../../../profile/presentation/pages/user_profile_screen.dart';
import '../../../welcome/presentation/pages/welcome_sleep_screen.dart';
import '../../../music/presentation/pages/music_v2_screen.dart';

class MeditateScreen extends StatefulWidget {
  const MeditateScreen({super.key});

  @override
  State<MeditateScreen> createState() => _MeditateScreenState();
}

class _MeditateScreenState extends State<MeditateScreen> {
  // Hardcoded category list for the top scroller
  final List<String> categories = ['All', 'My', 'Anxious', 'Sleep', 'Kids'];
  int _selectedCategoryIndex = 0;

  // Initialize to 2 (Meditate tab)
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const HomeScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
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
    final width = size.width;
    final height = size.height;
    // Reference: 414 x 896
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    // -------------------------------------------------------------
    // 📏 PIXEL PERFECT SIZING LOGIC
    // -------------------------------------------------------------
    final double cardWidth = w(176.4);
    final double tallCardHeight = h(210);
    final double shortCardHeight = h(167);
    final double bannerHeight = h(106.6); // 0.119 * 896 approx
    // -------------------------------------------------------------

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: h(20)),
          child: Column(
            children: [
              SizedBox(height: h(20)),
              // Header
              Text(
                'Meditate',
                style: AppTypography.h1.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: fs(28),
                ),
              ),
              SizedBox(height: h(10)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w(40)),
                child: Text(
                  'we can learn how to recognize when our minds are doing their normal everyday acrobatics.',
                  textAlign: TextAlign.center,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: fs(16),
                  ),
                ),
              ),
              SizedBox(height: h(30)),

              // Categories List
              SizedBox(
                height: h(95),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: w(20)),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => SizedBox(width: w(20)),
                  itemBuilder: (context, index) {
                    final bool isSelected = _selectedCategoryIndex == index;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selectedCategoryIndex = index),
                      child: Column(
                        children: [
                          Container(
                            width: w(65),
                            height: w(65),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.iconMuted,
                              borderRadius: BorderRadius.circular(w(25)),
                            ),
                            child: Icon(
                              _getIconForCategory(categories[index]),
                              color: AppColors.textInverse,
                              size: w(30),
                            ),
                          ),
                          SizedBox(height: h(10)),
                          Text(
                            categories[index],
                            style:
                                (isSelected
                                        ? AppTypography.labelBold
                                        : AppTypography.label)
                                    .copyWith(
                                      color: isSelected
                                          ? AppColors.textPrimary
                                          : AppColors.textSecondary,
                                      fontSize: fs(14),
                                    ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: h(20)),

              // Daily Calm Banner
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w(20)),
                child: Container(
                  height: bannerHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.accentCalm,
                    borderRadius: BorderRadius.circular(w(20)),
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dailyCalmBg),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(w(25.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Daily Calm',
                                  style: AppTypography.h2.copyWith(
                                    color: AppColors.textPrimary,
                                    fontSize: fs(18),
                                  ),
                                ),
                                SizedBox(height: h(5)),
                                Text(
                                  'APR 30 • PAUSE PRACTICE',
                                  style: AppTypography.caption.copyWith(
                                    fontSize: fs(12),
                                    color: AppColors.textPrimary.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: w(40),
                              height: w(40),
                              decoration: const BoxDecoration(
                                color: AppColors.textPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: AppColors.textInverse,
                                size: w(20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: h(20)),

              // Masonry Grid using your exact sizes
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w(20)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // LEFT COLUMN
                    Column(
                      children: [
                        MasonryCard(
                          title: '7 Days of Calm',
                          imageAsset: AppAssets.sevenDays,
                          width: cardWidth,
                          height: tallCardHeight,
                          color: AppColors.primary,
                          w: w,
                          h: h,
                          fs: fs,
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a1, a2) =>
                                    MusicV2Screen(
                                      trackId: 'track_gen_1', // TODO: Replace with actual track ID for "7 Days of Calm"
                                    ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: h(20)),
                        MasonryCard(
                          title: 'Turning Pain',
                          imageAsset: AppAssets.beach,
                          width: cardWidth,
                          height: shortCardHeight,
                          color: AppColors.accentMint,
                          w: w,
                          h: h,
                          fs: fs,
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a1, a2) =>
                                    MusicV2Screen(
                                      trackId: 'track_gen_1', // TODO: Replace with actual track ID for "7 Days of Calm"
                                    ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    // RIGHT COLUMN
                    Column(
                      children: [
                        MasonryCard(
                          title: 'Anxiety Release',
                          imageAsset: AppAssets.autumn,
                          width: cardWidth,
                          height: shortCardHeight,
                          color: AppColors.accentYellow,
                          w: w,
                          h: h,
                          fs: fs,
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a1, a2) =>
                                    MusicV2Screen(
                                      trackId: 'track_gen_1', // TODO: Replace with actual track ID for "7 Days of Calm"
                                    ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: h(20)),
                        MasonryCard(
                          title: 'Sunny Mornings',
                          imageAsset: AppAssets.greenHill,
                          width: cardWidth,
                          height: tallCardHeight,
                          color: AppColors.accentGreen,
                          w: w,
                          h: h,
                          fs: fs,
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a1, a2) =>
                                    MusicV2Screen(
                                      trackId: 'track_gen_1', // TODO: Replace with actual track ID for "7 Days of Calm"
                                    ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
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
      // -------------------------------------------------------------
      // NAVIGATION BAR
      // -------------------------------------------------------------
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        backgroundColor: AppColors.surface,
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'All':
        return Icons.grid_view_rounded;
      case 'My':
        return Icons.favorite_border;
      case 'Anxious':
        return Icons.sentiment_dissatisfied;
      case 'Sleep':
        return Icons.dark_mode_outlined;
      case 'Kids':
        return Icons.child_care;
      default:
        return Icons.circle;
    }
  }
}

class MasonryCard extends StatelessWidget {
  final String title, imageAsset;
  final double width, height;
  final Color color;
  final VoidCallback? onTap;
  final double Function(double) w;
  final double Function(double) h;
  final double Function(double) fs;

  const MasonryCard({
    super.key,
    required this.title,
    required this.imageAsset,
    required this.width,
    required this.height,
    required this.color,
    required this.w,
    required this.h,
    required this.fs,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(w(20)),
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(w(20)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, AppColors.cardOverlay],
                  stops: const [0.7, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: h(20),
              left: w(15),
              right: w(15),
              child: Text(
                title,
                style: AppTypography.h2.copyWith(
                  color: AppColors.textInverse,
                  fontSize: fs(18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}