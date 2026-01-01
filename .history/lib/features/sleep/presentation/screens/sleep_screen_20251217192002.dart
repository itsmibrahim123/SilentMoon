import 'package:flutter/material.dart';
import 'package:silent_moon/core/constants/app_colors.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../meditation/presentation/screens/meditate_screen.dart';
import '../../../music/presentation/screens/play_option_screen.dart';
import '../../../profile/presentation/screens/user_profile_screen.dart';
import 'package:silent_moon/core/widgets/bottom_nav_bar.dart';
import 'sleep_music_screen.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import '../../domain/models/track.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  // Hardcoded category list for the top scroller
  final List<String> categories = ['All', 'My', 'Anxious', 'Sleep', 'Kids'];
  int _selectedCategoryIndex = 0;
  int _selectedIndex = 1; // Sleep is selected (index 1)

  final Track _oceanMoon = Track(
    id: '1',
    trackType: 'sleep_story',
    title: 'The ocean moon',
    subtitle: 'Non-stop 8- hour mixes of our most popular sleep audio',
    duration: '8 hours',
    color: '#8E97FD',
    category: 'Sleep',
    imageAsset: AppAssets.oceanMoonBg,
    audioAsset: '',
  );

  final List<Track> _sleepStories = [
    Track(
      id: '2',
      trackType: 'sleep_story',
      title: 'Night Island',
      subtitle: '45 MIN • SLEEP MUSIC',
      duration: '45 min',
      color: '#AFDBC5',
      category: 'Sleep',
      imageAsset: AppAssets.moonClouds,
      audioAsset: '',
    ),
    Track(
      id: '3',
      trackType: 'sleep_story',
      title: 'Sweet Sleep',
      subtitle: '45 MIN • SLEEP MUSIC',
      duration: '45 min',
      color: '#AFDBC5',
      category: 'Sleep',
      imageAsset: AppAssets.goodNight,
      audioAsset: '',
    ),
    Track(
      id: '4',
      trackType: 'sleep_story',
      title: 'Good Night',
      subtitle: '45 MIN • SLEEP MUSIC',
      duration: '45 min',
      color: '#AFDBC5',
      category: 'Sleep',
      imageAsset: AppAssets.goodNight,
      audioAsset: '',
    ),
    Track(
      id: '5',
      trackType: 'sleep_story',
      title: 'Moon Clouds',
      subtitle: '45 MIN • SLEEP MUSIC',
      duration: '45 min',
      color: '#AFDBC5',
      category: 'Sleep',
      imageAsset: AppAssets.moonClouds,
      audioAsset: '',
    ),
  ];

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
    // Reference: 414 x 896
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    return Scaffold(
      backgroundColor: const Color(0xFF03174C),
      body: Stack(
        children: [
          // Background image - fills top of screen completely
          Positioned(
            top: 0, // Move image to top edge
            left: 0, // Align left edge
            right: 0, // Align right edge
            child: Image.asset(
              AppAssets.sleepScreenBg,
              fit: BoxFit.fill, // Cover the top
              width: MediaQuery.of(context).size.width,
              height: h(275), // Keep height as before
            ),
          ),

          // Main scrollable content with SafeArea
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: h(112), top: 0),
              child: Column(
                children: [
                  SizedBox(height: h(66)),
                  // Sleep Stories Title
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
                  // Subtitle
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
                  // Category scroller
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
                  SizedBox(height: h(20)),
                  // Main banner - The Ocean Moon
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w(20)),
                    child: _SleepStoryCard(
                      track: _oceanMoon,
                      w: w,
                      h: h,
                      fs: fs,
                      isMainBanner: true,
                    ),
                  ),
                  SizedBox(height: h(20)),
                  // Sleep cards row
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: w(20)),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: w(177) / h(177),
                      crossAxisSpacing: w(20),
                      mainAxisSpacing: h(20),
                    ),
                    itemCount: _sleepStories.length,
                    itemBuilder: (context, index) {
                      return _SleepStoryCard(
                        track: _sleepStories[index],
                        w: w,
                        h: h,
                        fs: fs,
                      );
                    },
                  ),
                  SizedBox(height: h(40)),
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

class _SleepStoryCard extends StatelessWidget {
  final Track track;
  final double Function(double) w;
  final double Function(double) h;
  final double Function(double) fs;
  final bool isMainBanner;

  const _SleepStoryCard({
    required this.track,
    required this.w,
    required this.h,
    required this.fs,
    this.isMainBanner = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PlayOptionScreen(),
          ),
        );
      },
      child: isMainBanner ? _buildMainBanner() : _buildSleepCard(),
    );
  }

  Widget _buildMainBanner() {
    return Container(
      height: h(233),
      width: w(373.6),
      decoration: BoxDecoration(
        color: Color(int.parse(track.color.substring(1, 7), radix: 16) + 0xFF000000),
        borderRadius: BorderRadius.circular(w(10)),
        image: DecorationImage(
          image: AssetImage(track.imageAsset),
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
               color: AppColors.textWhite.withValues(alpha: 0.2)
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
                  padding: EdgeInsets.symmetric(
                    horizontal: w(20),
                  ),
                  child: Text(
                    track.subtitle,
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
    );
  }

  Widget _buildSleepCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: w(177),
          height: h(122.93),
          decoration: BoxDecoration(
            color: Color(int.parse(track.color.substring(1, 7), radix: 16) + 0xFF000000),
            borderRadius: BorderRadius.circular(w(10)),
            image: DecorationImage(
              image: AssetImage(track.imageAsset),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: h(10)),
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
          track.subtitle,
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.w400,
            fontSize: fs(11),
            color: const Color(0xFF98A1BD),
            letterSpacing: 0.05,
          ),
        ),
      ],
    );
  }
}