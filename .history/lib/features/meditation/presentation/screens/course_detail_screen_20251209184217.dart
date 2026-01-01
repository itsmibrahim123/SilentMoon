import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../favorites/presentation/screens/favorite_screen.dart';
import '../../../downloads/presentation/screens/download_screen.dart';
import '../../../music/presentation/screens/music_v2_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool isMaleVoice = true;

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
      body: Stack(
        children: [
          // Header Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: h(288.78),
              child: Stack(
                children: [
                  Positioned(
                    top: h(-10),
                    left: w(-0.36),
                    child: Image.asset(
                      'assets/images/sun.png',
                      width: w(414),
                      height: h(288.78),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w(20.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h(320.14)),
                    // Title
                    Text(
                      'Happy Morning',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w700,
                        fontSize: fs(34.0),
                        color: const Color(0xFF3F414E),
                      ),
                    ),
                    SizedBox(height: h(10.0)),
                    // Subtitle
                    Text(
                      'COURSE',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w400,
                        fontSize: fs(14.0),
                        letterSpacing: 0.05 * fs(14.0),
                        color: const Color(0xFFA1A4B2),
                      ),
                    ),
                    SizedBox(height: h(15.0)),
                    // Description
                    Text(
                      'Ease the mind into a restful night’s sleep with these deep, amblent tones.',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w300,
                        fontSize: fs(16.0),
                        height: 1.45,
                        color: const Color(0xFFA1A4B2),
                      ),
                    ),
                    SizedBox(height: h(30.0)),
                    // Stats
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/like.svg',
                          width: w(20.0),
                          height: h(18.0),
                          colorFilter: const ColorFilter.mode(
                            Color(0xFFFF84A2),
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: w(10.0)),
                        Text(
                          '24.234 Favorits',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontSize: fs(14.0),
                            color: const Color(0xFFA1A4B2),
                          ),
                        ),
                        SizedBox(width: w(30.0)),
                        Image.asset(
                          'assets/images/headphones.png',
                          width: w(20.0),
                          height: h(18.0),
                          color: const Color(0xFF7FD2F2),
                        ),
                        SizedBox(width: w(10.0)),
                        Text(
                          '34.234 Lestening',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontSize: fs(14.0),
                            color: const Color(0xFFA1A4B2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h(40.0)),
                    // Narrator Section
                    Text(
                      'Pick a Narrator',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w700,
                        fontSize: fs(20.0),
                        color: const Color(0xFF3F414E),
                      ),
                    ),
                    SizedBox(height: h(30.0)),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => isMaleVoice = true),
                          child: Text(
                            'MALE VOICE',
                            style: TextStyle(
                              fontFamily: 'HelveticaNeue',
                              fontSize: fs(16.0),
                              letterSpacing: 0.05 * fs(16.0),
                              color: isMaleVoice
                                  ? const Color(0xFF8E97FD)
                                  : const Color(0xFFA1A4B2),
                            ),
                          ),
                        ),
                        SizedBox(width: w(70.0)),
                        GestureDetector(
                          onTap: () => setState(() => isMaleVoice = false),
                          child: Text(
                            'FEMALE VOICE',
                            style: TextStyle(
                              fontFamily: 'HelveticaNeue',
                              fontSize: fs(16.0),
                              letterSpacing: 0.05 * fs(16.0),
                              color: !isMaleVoice
                                  ? const Color(0xFF8E97FD)
                                  : const Color(0xFFA1A4B2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h(15.0)),
                    Stack(
                      children: [
                        Container(
                          height: 2,
                          width: double.infinity,
                          color: const Color(0xFFE4E6FD),
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          left: isMaleVoice ? 0 : w(174.0),
                          child: Container(
                            height: 2,
                            width: w(isMaleVoice ? 104.03 : 126.32),
                            color: const Color(0xFF8E97FD),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h(20.0)),
                    // Session List
                    _SessionListItem(
                      icon: 'assets/images/play.png',
                      title: 'Focus Attention',
                      duration: '10 MIN',
                      isFirst: true,
                    ),
                    _SessionListItem(
                      icon: 'assets/images/play.png',
                      title: 'Body Scan',
                      duration: '5 MIN',
                    ),
                    _SessionListItem(
                      icon: 'assets/images/play.png',
                      title: 'Making Happiness',
                      duration: '3 MIN',
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Header Action Buttons
          Positioned(
            top: h(50.0),
            left: w(20.0),
            right: w(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _CircularButton(
                  icon: Icons.arrow_back,
                  onPressed: () => Navigator.pop(context),
                ),
                Row(
                  children: [
                    _CircularButton(
                      iconAsset: 'assets/icons/like.svg',
                      isDark: true,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FavoriteScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: w(15.0)),
                    _CircularButton(
                      iconAsset: 'assets/icons/download.svg',
                      isDark: true,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DownloadScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(20)),
        child: SizedBox(
          width: double.infinity,
          height: h(63),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MusicV2Screen()),
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
              'Start Listening',
              style: TextStyle(
                fontFamily: 'HelveticaNeue',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.05,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CircularButton extends StatelessWidget {
  final IconData? icon;
  final String? iconAsset;
  final bool isDark;
  final VoidCallback onPressed;

  const _CircularButton({
    this.icon,
    this.iconAsset,
    this.isDark = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark
          ? const Color(0xFF03174C).withOpacity(0.5)
          : const Color(0xFFF2F2F2),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: icon != null
                ? Icon(icon, color: const Color(0xFF3F414E), size: 22)
                : iconAsset!.endsWith('.svg')
                ? SvgPicture.asset(
                    iconAsset!,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFE6E7F2),
                      BlendMode.srcIn,
                    ),
                    width: 22,
                    height: 22,
                  )
                : Image.asset(
                    iconAsset!,
                    color: const Color(0xFFE6E7F2),
                    width: 22,
                    height: 22,
                  ),
          ),
        ),
      ),
    );
  }
}

class _SessionListItem extends StatelessWidget {
  final String icon;
  final String title;
  final String duration;
  final bool isFirst;

  const _SessionListItem({
    required this.icon,
    required this.title,
    required this.duration,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    const double circleSize = 46;
    const double iconSize = 22;

    return Column(
      children: [
        const SizedBox(height: 20),

        Row(
          children: [
            Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFirst ? const Color(0xFF8E97FD) : Colors.white,
                border: isFirst
                    ? null
                    : Border.all(color: const Color(0xFFA1A4B2), width: 1.2),
              ),
              child: Center(
                child: Image.asset(
                  icon,
                  width: iconSize,
                  height: iconSize,
                  color: isFirst ? Colors.white : const Color(0xFFA1A4B2),
                ),
              ),
            ),

            const SizedBox(width: 18),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'HelveticaNeue',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF3F414E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: const TextStyle(
                    fontFamily: 'HelveticaNeue',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFFA1A4B2),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        if (!isFirst)
          Container(
            height: 1,
            color: const Color(0xFFADB8D9).withOpacity(0.15),
          ),
      ],
    );
  }
}
