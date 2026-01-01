import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import '../../../favorites/presentation/screens/favorite_screen.dart';
import '../../../downloads/presentation/screens/download_screen.dart';
import 'music_screen.dart';

class PlayOptionScreen extends StatelessWidget {
  const PlayOptionScreen({super.key});

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
                      AppAssets.night,
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
                    // Title - Night Island
                    Text(
                      'Night Island',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w700,
                        fontSize: fs(34.0),
                        height: 1.081,
                        color: const Color(0xFFE6E7F2),
                      ),
                    ),
                    SizedBox(height: h(10.0)),
                    // Duration and Category
                    Row(
                      children: [
                        Text(
                          '45 MIN',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w400,
                            fontSize: fs(14.0),
                            height: 1.081,
                            letterSpacing: 0.05 * fs(14.0),
                            color: const Color(0xFF98A1BD),
                          ),
                        ),
                        SizedBox(width: w(10.0)),
                        Container(
                          width: w(3.25),
                          height: h(3.25),
                          decoration: BoxDecoration(
                            color: const Color(0xFF98A1BD),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: w(10.0)),
                        Text(
                          'SLEEP MUSIC',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w400,
                            fontSize: fs(14.0),
                            height: 1.081,
                            letterSpacing: 0.05 * fs(14.0),
                            color: const Color(0xFF98A1BD),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h(15.0)),
                    // Description
                    Text(
                      'Ease the mind into a restful night\'s sleep with these deep, amblent tones.',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w300,
                        fontSize: fs(16.0),
                        height: 1.451,
                        color: const Color(0xFF98A1BD),
                      ),
                    ),
                    SizedBox(height: h(30.0)),
                    // Stats
                    Row(
                      children: [
                        Container(
                          width: w(20),
                          height: h(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFE6E7F2),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.favorite,
                            size: w(12),
                            color: const Color(0xFFE6E7F2),
                          ),
                        ),
                        SizedBox(width: w(10.0)),
                        Text(
                          '24.234 Favorites',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontSize: fs(14.0),
                            height: 1.081,
                            color: const Color(0xFFE6E7F2),
                          ),
                        ),
                        SizedBox(width: w(30.0)),
                        Image.asset(
                          AppAssets.headphones,
                          width: w(20.0),
                          height: h(20.0),
                          color: const Color(0xFFE6E7F2),
                        ),
                        SizedBox(width: w(10.0)),
                        Text(
                          '34.234 Listening',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontSize: fs(14.0),
                            height: 1.081,
                            color: const Color(0xFFE6E7F2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h(40.0)),
                    // Divider
                    Container(height: 1, color: const Color(0x2698A1BD)),
                    SizedBox(height: h(30.0)),
                    // Related Section
                    Text(
                      'Related',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w400,
                        fontSize: fs(24.0),
                        height: 1.081,
                        color: const Color(0xFFE6E7F2),
                      ),
                    ),
                    SizedBox(height: h(20.0)),
                    // Cards Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _SleepCard(
                          imageAsset: AppAssets.moon1,
                          title: 'Moon Clouds',
                          duration: '45 MIN',
                          category: 'SLEEP MUSIC',
                        ),
                        _SleepCard(
                          imageAsset: 'assets/images/moon2.png',
                          title: 'Sweet Sleep',
                          duration: '45 MIN',
                          category: 'SLEEP MUSIC',
                        ),
                      ],
                    ),
                    SizedBox(height: h(60.0)),
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
                  isDark: true,
                ),
                Row(
                  children: [
                    _CircularButton(
                      iconAsset: 'assets/icons/favorite.svg',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FavoriteScreen(),
                          ),
                        );
                      },
                      isDark: true,
                    ),
                    SizedBox(width: w(15.0)),
                    _CircularButton(
                      iconAsset: 'assets/icons/download.svg',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DownloadScreen(),
                          ),
                        );
                      },
                      isDark: true,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // PLAY Button
          Positioned(
            left: w(20.44),
            bottom: h(30.0),
            right: w(20.0),
            child: Container(
              width: w(374),
              height: h(63),
              decoration: BoxDecoration(
                color: const Color(0xFF8E97FD),
                borderRadius: BorderRadius.circular(w(38)),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E97FD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w(38)),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MusicScreen(),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    'PLAY',
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.w400,
                      fontSize: fs(14),
                      height: 1.081,
                      letterSpacing: 0.05 * fs(14),
                      color: const Color(0xFFF6F1FB),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
      color: isDark ? const Color(0x8003174C) : const Color(0xFFE6E7F2),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 55,
          height: 55,
          child: Center(
            child: icon != null
                ? Icon(
                    icon,
                    color: isDark
                        ? const Color(0xFFE6E7F2)
                        : const Color(0xFF3F414E),
                    size: 24,
                  )
                : iconAsset!.endsWith('.svg')
                ? SvgPicture.asset(iconAsset!, width: 55, height: 55)
                : Image.asset(iconAsset!, width: 20, height: 20),
          ),
        ),
      ),
    );
  }
}

class _SleepCard extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String duration;
  final String category;

  const _SleepCard({
    required this.imageAsset,
    required this.title,
    required this.duration,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    return SizedBox(
      width: w(177),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: w(177),
            height: h(122.93),
            decoration: BoxDecoration(
              color: const Color(0xFFAFDBC5),
              borderRadius: BorderRadius.circular(w(10)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(w(10)),
              child: Image.asset(imageAsset, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: h(20.0)),
          // Title
          Text(
            title,
            style: TextStyle(
              fontFamily: 'HelveticaNeue',
              fontWeight: FontWeight.w700,
              fontSize: fs(18.0),
              height: 1.081,
              color: const Color(0xFFE6E7F2),
            ),
          ),
          SizedBox(height: h(5.0)),
          // Duration and Category
          Row(
            children: [
              Text(
                duration,
                style: TextStyle(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.w400,
                  fontSize: fs(11.0),
                  height: 1.081,
                  letterSpacing: 0.05 * fs(11.0),
                  color: const Color(0xFF98A1BD),
                ),
              ),
              SizedBox(width: w(10.0)),
              Container(
                width: w(3.25),
                height: h(3.25),
                decoration: BoxDecoration(
                  color: const Color(0xFF98A1BD),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: w(10.0)),
              Text(
                category,
                style: TextStyle(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.w400,
                  fontSize: fs(11.0),
                  height: 1.081,
                  letterSpacing: 0.05 * fs(11.0),
                  color: const Color(0xFF98A1BD),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
