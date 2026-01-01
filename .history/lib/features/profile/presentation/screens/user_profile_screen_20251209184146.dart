import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../downloads/presentation/screens/download_screen.dart';
import '../../../favorites/presentation/screens/favorite_screen.dart';
import 'package:silent_moon/core/widgets/bottom_nav_bar.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../meditation/presentation/screens/meditate_screen.dart';
import '../../../music/presentation/screens/music_v2_screen.dart';
import '../../../meditation/presentation/screens/choose_topic_screen.dart';
import '../../../music/presentation/screens/play_option_screen.dart';
import '../../../sleep/presentation/screens/sleep_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int _selectedIndex = 5; // Profile tab is index 5 with Play in middle

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
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
          pageBuilder: (context, animation1, animation2) =>
              const SleepScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 2) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const PlayOptionScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 3) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const MeditateScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 4) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const MusicV2Screen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  // Responsive width and height helpers
  double w(double px) => MediaQuery.of(context).size.width * px / 414;
  double h(double px) => MediaQuery.of(context).size.height * px / 896;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double bottomNavHeight = size.height * 0.11;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Header image fills the top of the screen
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/user.png',
              width: size.width,
              height: size.height * 0.51, // ~288px for 896px height
              fit: BoxFit.fill,
            ),
          ),
          // Content overlays below header
          Positioned.fill(
            top: size.height * 0.32,
            child: SafeArea(
              top: false, // allow header to go under status bar
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 0.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 150),

                    // View Favorites Button with heart icon
                    _buildProfileButton(
                      context,
                      label: 'View Favorites',
                      iconAsset: 'assets/icons/favorite.svg',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FavoriteScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // View Downloaded Button with download icon
                    _buildProfileButton(
                      context,
                      label: 'View Downloaded',
                      iconAsset: 'assets/icons/download.svg',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DownloadScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Edit Profile Button
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ChooseTopicScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8E97FD),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(38),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 0.05,
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: SizedBox(
        height: bottomNavHeight,
        child: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  // Helper method to build profile action buttons
  Widget _buildProfileButton(
    BuildContext context, {
    required String label,
    required String iconAsset,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF8E97FD), width: 2),
          foregroundColor: const Color(0xFF8E97FD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(38),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconAsset.endsWith('.svg')
                ? SvgPicture.asset(
                    iconAsset,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF8E97FD),
                      BlendMode.srcIn,
                    ),
                  )
                : Image.asset(
                    iconAsset,
                    width: 24,
                    height: 24,
                    color: const Color(0xFF8E97FD),
                  ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'HelveticaNeue',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 0.05,
                color: Color(0xFF8E97FD),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
