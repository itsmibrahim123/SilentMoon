import 'package:flutter/material.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../meditation/presentation/screens/meditate_screen.dart';
import '../../../music/presentation/screens/music_v2_screen.dart';
import '../../../music/presentation/screens/play_option_screen.dart';
import '../../../profile/presentation/screens/user_profile_screen.dart';
import 'package:silent_moon/core/widgets/bottom_nav_bar.dart';

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
      // Already on SleepScreen
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
    } else if (index == 5) {
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
    final Size size = MediaQuery.of(context).size;

    // Responsive sizing based on 414x896 design
    final double cardWidth = size.width * 0.4275; // 177px / 414px
    final double cardHeight = size.height * 0.1372; // 122.93px / 896px
    final double mainBannerHeight = size.height * 0.26; // 233px / 896px
    final double mainBannerWidth = size.width * 0.9024; // 373.6px / 414px

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
              'assets/images/SleepScreenBG.png',
              fit: BoxFit.fill, // Cover the top
              width: MediaQuery.of(context).size.width,
              height: 275, // Keep height as before
            ),
          ),

          // Main scrollable content with SafeArea
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 112, top: 0),
              child: Column(
                children: [
                  const SizedBox(height: 66),
                  // Sleep Stories Title
                  const Center(
                    child: Text(
                      'Sleep Stories',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Color(0xFFE6E7F2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Subtitle
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 69),
                    child: Text(
                      'Soothing bedtime stories to help you fall into a deep and natural sleep',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Color(0xFFEBEAEC),
                        height: 1.35,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Category scroller
                  SizedBox(
                    height: 95,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 20),
                      itemBuilder: (context, index) {
                        final isSelected = _selectedCategoryIndex == index;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategoryIndex = index),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF8E97FD)
                                      : const Color(0xFF586894),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Icon(
                                  _getIconForCategory(categories[index]),
                                  color: const Color(0xFFE6E7F2),
                                  size: 30,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                categories[index],
                                style: TextStyle(
                                  fontFamily: 'HelveticaNeue',
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 16,
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
                  const SizedBox(height: 20),
                  // Main banner - The Ocean Moon
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlayOptionScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: mainBannerHeight,
                        width: mainBannerWidth,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8E97FD),
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/OceanMoonBG.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Lock icon
                            Positioned(
                              top: 10,
                              left: 11,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.lock_outline,
                                  color: Color(0xFFE6E7F2),
                                  size: 16,
                                ),
                              ),
                            ),
                            // Center content
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'The ocean moon',
                                    style: TextStyle(
                                      fontFamily: 'Garamond Premier Pro',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 36,
                                      color: Color(0xFFFFE7BF),
                                      letterSpacing: 0.02,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      'Non-stop 8- hour mixes of our most popular sleep audio',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                        color: Color(0xFFF9F9FF),
                                        height: 1.35,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEBEAEC),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: const Text(
                                      'START',
                                      style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Color(0xFF3F414E),
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
                  ),
                  const SizedBox(height: 20),
                  // Sleep cards row 1
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SleepCard(
                          title: 'Night Island',
                          subtitle: '45 MIN • SLEEP MUSIC',
                          width: cardWidth,
                          height: cardHeight,
                          imageAsset: 'assets/images/MoonClouds.png',
                          color: const Color(0xFFAFDBC5),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PlayOptionScreen(),
                              ),
                            );
                          },
                        ),
                        SleepCard(
                          title: 'Sweet Sleep',
                          subtitle: '45 MIN • SLEEP MUSIC',
                          width: cardWidth,
                          height: cardHeight,
                          imageAsset: 'assets/images/GoodNight.png',
                          color: const Color(0xFFAFDBC5),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PlayOptionScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Sleep cards row 2
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SleepCard(
                          title: 'Good Night',
                          subtitle: '45 MIN • SLEEP MUSIC',
                          width: cardWidth,
                          height: cardHeight,
                          imageAsset: 'assets/images/GoodNight.png',
                          color: const Color(0xFFAFDBC5),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PlayOptionScreen(),
                              ),
                            );
                          },
                        ),
                        SleepCard(
                          title: 'Moon Clouds',
                          subtitle: '45 MIN • SLEEP MUSIC',
                          width: cardWidth,
                          height: cardHeight,
                          imageAsset: 'assets/images/MoonClouds.png',
                          color: const Color(0xFFAFDBC5),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PlayOptionScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
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

class SleepCard extends StatelessWidget {
  final String title, subtitle, imageAsset;
  final double width, height;
  final Color color;
  final VoidCallback? onTap;

  const SleepCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.width,
    required this.height,
    required this.imageAsset,
    required this.color,
    this.onTap,
  });

  Widget _buildCloud(double width, double height, double opacity) {
    return CustomPaint(
      size: Size(width, height),
      painter: CloudPainter(opacity: opacity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imageAsset),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Cloud decorations
                  Positioned(
                    top: 10,
                    left: 20,
                    child: _buildCloud(30, 20, 0.3),
                  ),
                  Positioned(
                    top: 15,
                    right: 30,
                    child: _buildCloud(25, 18, 0.25),
                  ),
                  Positioned(top: 5, left: 50, child: _buildCloud(20, 15, 0.2)),
                  Positioned(
                    top: 25,
                    right: 15,
                    child: _buildCloud(22, 16, 0.25),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.4),
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'HelveticaNeue',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFFE6E7F2),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  subtitle.split(' • ')[0],
                  style: const TextStyle(
                    fontFamily: 'HelveticaNeue',
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    color: Color(0xFF98A1BD),
                    letterSpacing: 0.05,
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  width: 3.25,
                  height: 3.25,
                  decoration: const BoxDecoration(
                    color: Color(0xFF98A1BD),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  subtitle.split(' • ')[1],
                  style: const TextStyle(
                    fontFamily: 'HelveticaNeue',
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    color: Color(0xFF98A1BD),
                    letterSpacing: 0.05,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CloudPainter extends CustomPainter {
  final double opacity;

  CloudPainter({this.opacity = 0.3});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: opacity)
      ..style = PaintingStyle.fill;

    // Draw cloud shape using multiple circles
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Main cloud body
    canvas.drawCircle(Offset(centerX, centerY), size.width * 0.3, paint);

    // Left puff
    canvas.drawCircle(
      Offset(centerX - size.width * 0.25, centerY),
      size.width * 0.25,
      paint,
    );

    // Right puff
    canvas.drawCircle(
      Offset(centerX + size.width * 0.25, centerY),
      size.width * 0.25,
      paint,
    );

    // Top puff
    canvas.drawCircle(
      Offset(centerX, centerY - size.height * 0.2),
      size.width * 0.2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
