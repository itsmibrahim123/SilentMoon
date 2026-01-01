import 'package:flutter/material.dart';
import '../../../sleep/presentation/screens/sleep_screen.dart';
import '../../../music/presentation/screens/music_v2_screen.dart';
import '../../../meditation/presentation/screens/meditate_screen.dart';
import '../../../profile/presentation/screens/user_profile_screen.dart';
import '../../../meditation/presentation/screens/course_detail_screen.dart';
import '../../../music/presentation/screens/play_option_screen.dart';
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
      // Already on HomeScreen
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const SleepScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const PlayOptionScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const MeditateScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const MusicV2Screen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 5) {
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

    // ============================================================
    // 👇 CONFIGURATION SECTION
    // ============================================================

    final double cardWidth = size.width * 0.4261;
    final double tallCardHeight = size.height * 0.2343;
    // ============================================================

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: 20.0,
            top: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Logo and Title ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Silent',
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/images/SilentMoonLogo.png',
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Moon',
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // --- Greeting ---
              const Text(
                'Good Morning, Afsar',
                style: TextStyle(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'We Wish you have a good day',
                style: TextStyle(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),

              // --- Courses Row ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CourseCard(
                    title: 'Basics',
                    subtitle: 'COURSE',
                    duration: '3-10 MIN',
                    color: const Color(0xFF8E97FD),
                    textColor: Colors.white,
                    buttonColor: Colors.white,
                    buttonTextColor: Colors.black87,
                    imageAsset: 'assets/images/BasicsCourse.png',
                    width: cardWidth,
                    height: tallCardHeight,
                    imageRightPadding: 0,
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
                    color: const Color(0xFFFFC97E),
                    textColor: Colors.black87,
                    buttonColor: const Color(0xFF3F414E),
                    buttonTextColor: Colors.white,
                    imageAsset: 'assets/images/RelaxationMusic.png',
                    width: cardWidth,
                    height: tallCardHeight,
                    imageRightPadding: 20,
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
              const SizedBox(height: 30),

              // --- Daily Thought ---
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF3F414E),
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/BackgroundImage.png'),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily Thought',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'MEDITATION • 3-10 MIN',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // --- Recommended ---
              const Text(
                'Recomended for you',
                style: TextStyle(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
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
                        color: const Color(0xFFAFDBC5),
                        imageAsset: 'assets/images/Focus.png',
                      ),
                    ),
                    const SizedBox(width: 15),
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
                        color: const Color(0xFFFFC97E),
                        imageAsset: 'assets/images/Happiness.png',
                      ),
                    ),
                    const SizedBox(width: 15),
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
                        color: const Color(0xFFAFDBC5),
                        imageAsset: 'assets/images/Focus.png',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // 👇 BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        backgroundColor: Colors.white,
      ),
    );
  }
}

// ... (Rest of your Card classes remain exactly the same) ...
class CourseCard extends StatelessWidget {
  final String title, subtitle, duration, imageAsset;
  final Color color, textColor, buttonColor, buttonTextColor;
  final double width, height, imageRightPadding;
  final VoidCallback? onTap;

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
    this.imageRightPadding = 20.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: imageRightPadding,
                child: Image.asset(imageAsset, height: 90, fit: BoxFit.contain),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: textColor,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: textColor.withValues(alpha: 179), // ~0.7 opacity
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          duration,
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: textColor.withValues(
                              alpha: 179,
                            ), // ~0.7 opacity
                          ),
                        ),
                        ElevatedButton(
                          onPressed: onTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            foregroundColor: buttonTextColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'START',
                            style: TextStyle(
                              fontFamily: 'HelveticaNeue',
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
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

  const RecommendationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 160,
          height: 120,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(imageAsset, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.w300,
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
