import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silent_moon/core/constants/app_colors.dart';
import 'package:silent_moon/core/widgets/bottom_nav_bar.dart';
import '../../data/datasources/session_remote_data_source.dart';
import '../../data/repositories/session_repository_impl.dart';
import '../../domain/entities/session.dart';
import '../../domain/usecases/get_sessions_use_case.dart';
import '../providers/home_provider.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import '../../../../core/styles/app_typography.dart';
import 'package:silent_moon/features/welcome/presentation/pages/welcome_sleep_screen.dart';
import '../../../meditation/presentation/pages/meditate_screen.dart';
import '../../../profile/presentation/pages/user_profile_screen.dart';
import '../../../meditation/presentation/pages/course_detail_screen.dart';
import '../../../sleep/presentation/pages/sleep_music_screen.dart';

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
    final auth = context.watch<AuthProvider>();
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    return ChangeNotifierProvider(
      create: (_) => HomeProvider(
        getSessionsUseCase: GetSessionsUseCase(
          SessionRepositoryImpl(
            remoteDataSource: SessionRemoteDataSourceImpl(
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
      )..loadData(),
      child: Scaffold(
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
                      'Good Morning, ',
                      style: AppTypography.h2.copyWith(
                        fontSize: fs(28),
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        auth.user?.displayName ?? 'Guest',
                        overflow: TextOverflow.ellipsis,
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

                // --- Recommended for you (Fetching from Firestore) ---
                Text(
                  'Recommended for you',
                  style: AppTypography.h2.copyWith(
                    fontSize: fs(24),
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: h(20)),
                SizedBox(
                  height: h(210), // Adjust height for session cards
                  child: Consumer<HomeProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (provider.errorMessage != null) {
                        return Center(
                          child: Text('Error: ${provider.errorMessage}'),
                        );
                      }
                      if (provider.sessions.isEmpty) {
                        return const Center(child: Text('No sessions found'));
                      }
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.sessions.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: w(20)),
                        itemBuilder: (context, index) {
                          return _SessionCard(
                            session: provider.sessions[index],
                            w: w,
                            h: h,
                            fs: fs,
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: h(30)),

                // --- Daily Thought (Static for now) ---
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
                              color: Colors.white70,
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
                SizedBox(height: h(20)),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          backgroundColor: AppColors.backgroundWhite,
        ),
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
            MaterialPageRoute(
              builder: (context) => CourseDetailScreen(session: session),
            ),
          );
        },
        child: Container(
          width: w(177),
          height: h(210),
          decoration: BoxDecoration(
            color: const Color(0xFF8E97FD), // Default color, can be dynamic
            borderRadius: BorderRadius.circular(w(20)),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  session.imageUrl, // Use imageUrl from model
                  height: h(90),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(), // Handle missing images
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
                      session.subtitle,
                      style: AppTypography.caption.copyWith(
                        fontSize: fs(12),
                        color: AppColors.textWhite.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: h(15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          session.duration,
                          style: AppTypography.caption.copyWith(
                            fontSize: fs(12),
                            color: AppColors.textWhite.withValues(alpha: 0.7),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: w(12),
                            vertical: h(5),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.textWhite,
                            borderRadius: BorderRadius.circular(w(20)),
                          ),
                          child: Text(
                            'START',
                            style: AppTypography.caption.copyWith(
                              fontSize: fs(11),
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
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
