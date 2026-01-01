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
import '../../domain/models/session.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Session> _sessions = [
    Session(
      id: '1',
      title: 'Basics',
      subtitle: 'COURSE',
      duration: '3-10 MIN',
      imageAsset: AppAssets.basicsCourse,
      color: AppColors.primaryPurple,
    ),
    Session(
      id: '2',
      title: 'Relaxation',
      subtitle: 'MUSIC',
      duration: '3-10 MIN',
      imageAsset: AppAssets.relaxationMusic,
      color: AppColors.accentOrange,
    ),
  ];

  final List<Session> _recommendations = [
    Session(
      id: '3',
      title: 'Focus',
      subtitle: 'MEDITATION • 3-10 MIN',
      imageAsset: AppAssets.focus,
      color: AppColors.accentGreen,
    ),
    Session(
      id: '4',
      title: 'Happiness',
      subtitle: 'MEDITATION • 3-10 MIN',
      imageAsset: AppAssets.happiness,
      color: AppColors.accentOrange,
    ),
    Session(
      id: '5',
      title: 'Focus',
      subtitle: 'MED',
      imageAsset: AppAssets.focus,
      color: AppColors.accentGreen,
    ),
  ];

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
              Row(
                children: [
                  Text(
                    'Good Morning, ', // Added a space here for separation
                    style: AppTypography.h2.copyWith(
                      fontSize: fs(28),
                      color: AppColors.textPrimary,
                    ),
                  ),
                  // 4. Display the actual username here
                  Expanded(
                    // Added Expanded to prevent overflow if the name is too long
                    child: Text(
                      auth.user?.displayName ?? 'Guest',
                      overflow: TextOverflow
                          .ellipsis, // Adds "..." if name is too long
                      style: AppTypography.h1.copyWith(
                        fontSize: fs(28),
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
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
              SizedBox(
                height: h(210),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _sessions.length,
                  separatorBuilder: (context, index) => SizedBox(width: w(20)),
                  itemBuilder: (context, index) {
                    return _SessionCard(
                      session: _sessions[index],
                      w: w,
                      h: h,
                      fs: fs,
                    );
                  },
                ),
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
                            color: AppColors.textWhite.withOpacity(0.7),
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
              SizedBox(
                height: h(170),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _recommendations.length,
                  separatorBuilder: (context, index) => SizedBox(width: w(15)),
                  itemBuilder: (context, index) {
                    return _RecommendationCard(
                      session: _recommendations[index],
                      w: w,
                      h: h,
                      fs: fs,
                    );
                  },
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

class _SessionCard extends StatelessWidget {
  final Session session;
  final double Function(double) w;
  final double Function(double) h;
  final double Function(double) fs;

  const _SessionCard({
    required this.session,
    required this.w,
    required this.h,
    required this.fs,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(w(20)),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CourseDetailScreen()),
          );
        },
        child: Container(
          width: w(177),
          height: h(210),
          decoration: BoxDecoration(
            color: session.color,
            borderRadius: BorderRadius.circular(w(20)),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  session.imageAsset,
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
                      session.title,
                      style: AppTypography.h2.copyWith(
                        fontSize: fs(20),
                        color: AppColors.textWhite,
                      ),
                    ),
                    Text(
                      session.subtitle ?? '',
                      style: AppTypography.caption.copyWith(
                        fontSize: fs(12),
                        color: AppColors.textWhite.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: h(15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          session.duration ?? '',
                          style: AppTypography.caption.copyWith(
                            fontSize: fs(12),
                            color: AppColors.textWhite.withOpacity(0.7),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CourseDetailScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.textWhite,
                            foregroundColor: AppColors.textPrimary,
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

class _RecommendationCard extends StatelessWidget {
  final Session session;
  final double Function(double) w;
  final double Function(double) h;
  final double Function(double) fs;

  const _RecommendationCard({
    required this.session,
    required this.w,
    required this.h,
    required this.fs,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CourseDetailScreen()),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: w(160),
            height: h(120),
            decoration: BoxDecoration(
              color: session.color,
              borderRadius: BorderRadius.circular(w(20)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(w(20)),
              child: Image.asset(session.imageAsset, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: h(10)),
          Text(
            session.title,
            style: AppTypography.h2.copyWith(
              fontSize: fs(16),
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            session.subtitle ?? '',
            style: AppTypography.caption.copyWith(
              fontSize: fs(12),
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
