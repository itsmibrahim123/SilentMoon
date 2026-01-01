import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silent_moon/core/widgets/bottom_nav_bar.dart';
import '../../data/datasources/track_remote_data_source.dart';
import '../../data/repositories/track_repository_impl.dart';
import '../../domain/entities/track.dart';
import '../../domain/usecases/get_tracks_use_case.dart';
import '../providers/sleep_provider.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../../../meditation/presentation/pages/meditate_screen.dart';
import '../../../profile/presentation/pages/user_profile_screen.dart';
import '../../../music/presentation/pages/music_screen.dart';
import 'sleep_music_screen.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  int _selectedIndex = 1;
  int _selectedCategoryIndex = 0;

  final List<String> categories = ['All', 'My', 'Anxious', 'Sleep', 'Kids'];

  final Track _oceanMoon = Track(
    id: 'ocean_moon_static',
    trackType: 'SLEEP STORY',
    title: 'The ocean moon',
    author: 'Non-stop 8- hour mixes',
    imageUrl: AppAssets.oceanMoonBg,
    audioUrl: '',
  );

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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    return ChangeNotifierProvider(
      create: (_) => SleepProvider(
        getTracksUseCase: GetTracksUseCase(
          TrackRepositoryImpl(
            remoteDataSource: TrackRemoteDataSourceImpl(
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
      )..loadData(),
      child: Scaffold(
        backgroundColor: const Color(0xFF03174C),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                AppAssets.sleepScreenBg,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: h(275),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: h(66)),
                    Center(
                      child: Text(
                        'Sleep Stories',
                        style: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontWeight: FontWeight.bold,
                          fontSize: fs(28),
                          color: const Color(0xFFE6E7F2),
                        ),
                      ),
                    ),
                    SizedBox(height: h(15)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(69)),
                      child: Text(
                        'Soothing bedtime stories to help you fall into a deep and natural sleep',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontWeight: FontWeight.w300,
                          fontSize: fs(16),
                          color: const Color(0xFFEBEAEC),
                          height: 1.35,
                        ),
                      ),
                    ),
                    SizedBox(height: h(30)),
                    // Category Scroller
                    SizedBox(
                      height: h(95),
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: w(20)),
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: w(20)),
                        itemBuilder: (context, index) {
                          final isSelected = _selectedCategoryIndex == index;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedCategoryIndex = index),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: w(65),
                                  height: w(65),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF8E97FD)
                                        : const Color(0xFF586894),
                                    borderRadius: BorderRadius.circular(w(25)),
                                  ),
                                  child: Icon(
                                    _getIconForCategory(categories[index]),
                                    color: const Color(0xFFE6E7F2),
                                    size: w(30),
                                  ),
                                ),
                                SizedBox(height: h(8)),
                                Text(
                                  categories[index],
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: fs(16),
                                    color: isSelected
                                        ? const Color(0xFFE6E7F2)
                                        : const Color(0xFF98A1BD),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: h(30)),
                    // Main Banner
                    _MainBanner(track: _oceanMoon, w: w, h: h, fs: fs),
                    SizedBox(height: h(30)),
                    // Dynamic Tracks
                    Consumer<SleepProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (provider.errorMessage != null) {
                          return Center(
                            child: Text(
                              'Error: ${provider.errorMessage}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }

                        if (provider.tracks.isEmpty) {
                          return const Center(
                            child: Text(
                              'No tracks found.',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: w(20)),
                          itemCount: provider.tracks.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: h(20)),
                          itemBuilder: (context, index) {
                            final track = provider.tracks[index];
                            return _TrackTile(track: track, w: w, h: h, fs: fs);
                          },
                        );
                      },
                    ),
                    SizedBox(height: h(20)),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          backgroundColor: const Color(0xFF03174D),
        ),
      ),
    );
  }
}

class _MainBanner extends StatelessWidget {
  final Track track;
  final double Function(double) w;
  final double Function(double) h;
  final double Function(double) fs;

  const _MainBanner({
    required this.track,
    required this.w,
    required this.h,
    required this.fs,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(20)),
      child: GestureDetector(
        onTap: () {
          // Map track ID to Firestore document ID
          final firestoreTrackId = track.id.startsWith('track') 
              ? track.id 
              : 'track_gen_${track.id}';
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MusicScreen(trackId: firestoreTrackId),
            ),
          );
        },
        child: Container(
          height: h(233),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF8E97FD),
            borderRadius: BorderRadius.circular(w(10)),
            image: DecorationImage(
              image: AssetImage(track.imageUrl),
              fit: BoxFit.contain,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: h(10),
                left: w(11),
                child: Container(
                  width: w(30),
                  height: w(30),
                  decoration: BoxDecoration(
                    color: AppColors.textWhite.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outline,
                    color: const Color(0xFFE6E7F2),
                    size: w(16),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      track.title,
                      style: TextStyle(
                        fontFamily: 'Garamond Premier Pro',
                        fontWeight: FontWeight.w600,
                        fontSize: fs(36),
                        color: const Color(0xFFFFE7BF),
                        letterSpacing: 0.02,
                      ),
                    ),
                    SizedBox(height: h(10)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(20)),
                      child: Text(
                        track.author,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontWeight: FontWeight.w300,
                          fontSize: fs(16),
                          color: const Color(0xFFF9F9FF),
                          height: 1.35,
                        ),
                      ),
                    ),
                    SizedBox(height: h(20)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: w(20),
                        vertical: h(10),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBEAEC),
                        borderRadius: BorderRadius.circular(w(25)),
                      ),
                      child: Text(
                        'START',
                        style: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontWeight: FontWeight.w400,
                          fontSize: fs(12),
                          color: const Color(0xFF3F414E),
                          letterSpacing: 0.05,
                        ),
                      ),
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

class _TrackTile extends StatelessWidget {
  final Track track;
  final double Function(double) w;
  final double Function(double) h;
  final double Function(double) fs;

  const _TrackTile({
    required this.track,
    required this.w,
    required this.h,
    required this.fs,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Map track ID to Firestore document ID
        final firestoreTrackId = track.id.startsWith('track') 
            ? track.id 
            : 'track_gen_${track.id}';
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicScreen(trackId: firestoreTrackId),
          ),
        );
      },
      child: Container(
        height: h(100),
        decoration: BoxDecoration(
          color: const Color(0xFF03174C),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: w(100),
              height: h(100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(track.imageUrl),
                  fit: BoxFit.cover,
                  onError: (e, s) {},
                ),
              ),
            ),
            SizedBox(width: w(15)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    track.title,
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.bold,
                      fontSize: fs(18),
                      color: const Color(0xFFE6E7F2),
                    ),
                  ),
                  SizedBox(height: h(5)),
                  Text(
                    '${track.author} • ${track.trackType}',
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.w400,
                      fontSize: fs(12),
                      color: const Color(0xFF98A1BD),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.play_circle_outline, color: Colors.white, size: w(40)),
          ],
        ),
      ),
    );
  }
}