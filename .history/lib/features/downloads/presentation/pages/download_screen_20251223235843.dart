import 'package:flutter/material.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import 'package:silent_moon/core/widgets/bottom_nav_bar.dart';
import 'package:silent_moon/features/sleep/data/models/track.dart';

import '../../../home/presentation/pages/home_screen.dart';
import '../../../meditation/presentation/pages/meditate_screen.dart';
import '../../../profile/presentation/pages/user_profile_screen.dart';
import '../../../sleep/presentation/pages/sleep_music_screen.dart';
import '../../../sleep/presentation/pages/sleep_screen.dart';
import '../../../sleep/presentation/utils/app_colors.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  int _selectedNavIndex = 4; // Profile tab highlights in bottom nav

  final List<Track> _downloadItems = [
    Track(
        id: '1',
        trackType: 'music',
        title: 'Night Island',
        subtitle: 'SLEEP MUSIC',
        imageAsset: AppAssets.moonClouds,
        color: '#AFDBC5',
        audioAsset: '',
        category: 'Sleep',
        duration: '45 MIN'),
    Track(
        id: '2',
        trackType: 'music',
        title: 'Sweet Sleep',
        subtitle: 'SLEEP MUSIC',
        imageAsset: AppAssets.goodNight,
        color: '#AFDBC5',
        audioAsset: '',
        category: 'Sleep',
        duration: '45 MIN'),
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
      backgroundColor: const Color(0xFF03174C),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w(20),
                    vertical: h(20),
                  ),
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
                              color: AppColors.faintWhite30,
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
                      // Downloads text (Centered)
                      Expanded(
                        child: Text(
                          'Downloads',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold,
                            fontSize: fs(28),
                            color: AppColors.lightBlueText,
                          ),
                        ),
                      ),
                      // Placeholder to balance the row for centering
                      SizedBox(width: w(55), height: w(55)),
                    ],
                  ),
                ),
                // Grid of Download Cards
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: w(20),
                      vertical: h(10),
                    ),
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 177 / 177,
                          crossAxisSpacing: w(15),
                          mainAxisSpacing: h(15),
                        ),
                    itemCount: _downloadItems.length,
                    itemBuilder: (context, index) {
                      final item = _downloadItems[index];
                      return _buildDownloadCard(item, w, h, fs);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedNavIndex,
        onItemTapped: _onItemTapped,
        backgroundColor: const Color(0xFF03174D), // match HomeScreen style
      ),
    );
  }

  Widget _buildDownloadCard(
    Track item,
    double Function(double) w,
    double Function(double) h,
    double Function(double) fs,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(int.parse(item.color.substring(1, 7), radix: 16) + 0xFF000000),
              borderRadius: BorderRadius.circular(w(10)),
              image: DecorationImage(
                image: AssetImage(item.imageAsset),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  // Fallback if image doesn't exist
                },
              ),
            ),
            child: Stack(
              children: [
                // Download indicator - Green checkmark button
                Positioned(
                  bottom: h(10),
                  right: w(10),
                  child: Container(
                    width: w(30),
                    height: w(30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightGreen,
                    ),
                    child: Icon(
                      Icons.check_circle,
                      size: w(20),
                      color: AppColors.whiteText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: h(10)),
        Text(
          item.title,
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.bold,
            fontSize: fs(18),
            color: AppColors.lightBlueText,
          ),
        ),
        SizedBox(height: h(5)),
        Text(
          item.subtitle,
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.w400,
            fontSize: fs(11),
            color: AppColors.mutedBlueGrey,
          ),
        ),
      ],
    );
  }
}