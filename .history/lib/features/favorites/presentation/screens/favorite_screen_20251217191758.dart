import 'package:flutter/material.dart';
import 'package:silent_moon/core/widgets/bottom_nav_bar.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import 'package:silent_moon/features/sleep/domain/models/track.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../../../meditation/presentation/screens/meditate_screen.dart';
import '../../../profile/presentation/screens/user_profile_screen.dart';
import '../../../sleep/presentation/screens/sleep_music_screen.dart';
import '../../../sleep/presentation/screens/sleep_screen.dart';
import '../../../sleep/presentation/utils/app_colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedNavIndex = 4; // Profile tab highlights in bottom nav

  final List<Track> _favoriteItems = [
    Track(
      id: '3',
      trackType: 'music',
      title: 'Focus',
      subtitle: 'MEDITATION • 3-10 MIN',
      imageAsset: AppAssets.focus,
      color: '#80A4FF',
      audioAsset: '',
      category: 'Meditation',
      duration: '3-10 MIN',
    ),
    Track(
      id: '4',
      trackType: 'music',
      title: 'Happiness',
      subtitle: 'MEDITATION • 3-10 MIN',
      imageAsset: AppAssets.happiness,
      color: '#FFC97E',
      audioAsset: '',
      category: 'Meditation',
      duration: '3-10 MIN',
    ),
  ];

  void _onItemTapped(int index) {
    if (_selectedNavIndex == index) return;

    setState(() {
      _selectedNavIndex = index;
    });

    if (index == 0) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const HomeScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 1) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const SleepScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 2) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const MeditateScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 3) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const SleepMusicScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 4) {
      Navigator.of(context).pushReplacement(
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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    // Reference: 414 x 896
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w(20), vertical: h(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Go Back Button
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: w(55),
                      height: w(55),
                      decoration: BoxDecoration(
                        color: AppColors.whiteText,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.faintBlack10,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.blackText,
                        size: w(20),
                      ),
                    ),
                  ),
                  // Favorites text (Centered)
                  Expanded(
                    child: Text(
                      'Favorites',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.bold,
                        fontSize: fs(28),
                        color: AppColors.blackText,
                      ),
                    ),
                  ),
                  // Placeholder to balance the row for centering
                  SizedBox(width: w(55), height: w(55)),
                ],
              ),
            ),
            // Uniform Grid View
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: w(20),
                  vertical: h(10),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      w(177) /
                      (h(160) +
                          h(50)), // Account for text below relative height
                  crossAxisSpacing: w(15),
                  mainAxisSpacing: h(20),
                ),
                itemCount: _favoriteItems.length,
                itemBuilder: (context, index) {
                  final item = _favoriteItems[index];
                  return _FavoriteCard(track: item, w: w, h: h, fs: fs);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedNavIndex,
        onItemTapped: _onItemTapped,
        backgroundColor: Colors.white, // match HomeScreen style
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final Track track;
  final double Function(double) w;
  final double Function(double) h;
  final double Function(double) fs;

  const _FavoriteCard({
    required this.track,
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
          width: double.infinity, // GridView takes care of width
          height: h(160),
          decoration: BoxDecoration(
            color: Color(
              int.parse(track.color.substring(1, 7), radix: 16) + 0xFF000000,
            ),
            borderRadius: BorderRadius.circular(w(20)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(w(20)),
            child: Stack(
              children: [
                // Image
                Image.asset(
                  track.imageAsset,
                  width: double.infinity,
                  height: h(160),
                  fit: BoxFit.cover,
                ),
                // Favorite heart icon overlay in top-right corner
                Positioned(
                  top: h(10),
                  right: w(10),
                  child: Container(
                    padding: EdgeInsets.all(w(6)),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white30,
                    ),
                    child: Icon(Icons.favorite, color: Colors.red, size: w(20)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: h(10)),
        Text(
          track.title,
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.bold,
            fontSize: fs(16),
            color: AppColors.blackText,
          ),
        ),
        Text(
          track.subtitle,
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.w300,
            fontSize: fs(12),
            color: AppColors.greyText,
          ),
        ),
      ],
    );
  }
}
