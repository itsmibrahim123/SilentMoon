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
import '../../../music/presentation/pages/play_option_screen.dart';
import 'sleep_music_screen.dart';
import 'package:silent_moon/core/constants/app_assets.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  int _selectedIndex = 1;

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
                  Expanded(
                    child: Consumer<SleepProvider>(
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
                  ),
                ],
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayOptionScreen(track: track),
          ),
        );
      },
      child: Container(
        height: h(100),
        decoration: BoxDecoration(
          color: const Color(0xFF03174C), // Or slightly lighter?
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
