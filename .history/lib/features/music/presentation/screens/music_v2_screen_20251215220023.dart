import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:silent_moon/features/downloads/presentation/screens/download_screen.dart';

import '../../../favorites/presentation/screens/favorite_screen.dart';

class MusicV2Screen extends StatefulWidget {
  const MusicV2Screen({super.key});

  @override
  State<MusicV2Screen> createState() => _MusicV2ScreenState();
}

class _MusicV2ScreenState extends State<MusicV2Screen> {
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
      backgroundColor: const Color(0xFFFAF7F3),
      body: Stack(
        children: [
          // Background images
          // musicV2BG1
          Positioned(
            left: w(-24.89),
            top: h(-29.73),
            child: Image.asset(
              'assets/images/musicV2BG1.png',
              width: w(209.9069366455078),
              height: h(209.9069366455078),
              fit: BoxFit.fill,
            ),
          ),
          // musicV2BG2
          Positioned(
            left: w(154.86),
            top: h(-29.73),
            child: Image.asset(
              'assets/images/musicV2BG2.png',
              width: w(272.1402587890625),
              height: h(481.71978759765625),
              fit: BoxFit.fill,
            ),
          ),
          // musicV2BG3
          Positioned(
            left: w(-34.62),
            top: h(523.45),
            child: Image.asset(
              'assets/images/musicV2BG3.png',
              width: w(272.1402587890635),
              height: h(481.71978759765807),
              fit: BoxFit.fill,
            ),
          ),
          // musicV2BG4
          Positioned(
            left: w(234.16),
            top: h(666.13),
            child: Transform.rotate(
              angle: -1.238, // -70.95 degrees
              child: Image.asset(
                'assets/images/musicV2BG4.png',
                width: w(209.9069429469485),
                height: h(209.9069429469485),
                fit: BoxFit.fill,
              ),
            ),
          ),

          // Top Action Buttons
          Positioned(
            left: w(20.0),
            top: h(50.0),
            child: _CircularButton(
              onPressed: () => Navigator.pop(context),
              child: const Icon(
                Icons.close,
                color: Color(0xFF3F414E),
                size: 24,
              ),
            ),
          ),
          // Favorite Button
          Positioned(
            left: w(269.0),
            top: h(50.0),
            width: w(55.0),
            height: h(55.0),
            child: _CircularButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FavoriteScreen(),
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/icons/musicV2favorite.svg',
                width: w(55),
                height: h(55),
              ),
            ),
          ),
          // Download Button
          Positioned(
            left: w(339.0),
            top: h(50.0),
            width: w(55.0),
            height: h(55.0),
            child: _CircularButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DownloadScreen(),
                  ),
                );
              },
              backgroundColor: const Color(0xFF03174C),
              child: SvgPicture.asset(
                'assets/icons/musicV2download.svg',
                width: w(55),
                height: h(55),
              ),
            ),
          ),

          // Title - Focus Attention
          Positioned(
            left: w(75.13),
            top: h(391.94),
            width: w(263.74),
            height: h(38.19),
            child: Center(
              child: Text(
                'Focus Attention',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.w700,
                  fontSize: fs(34.0),
                  height: 1.081,
                  color: const Color(0xFF3F414E),
                ),
              ),
            ),
          ),

          // Subtitle - 7 DAYS OF CALM
          Positioned(
            left: w(141.51),
            top: h(445.49),
            width: w(130.98),
            height: h(13.0),
            child: Center(
              child: Text(
                '7 DAYS OF CALM',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.w400,
                  fontSize: fs(14.0),
                  height: 1.081,
                  letterSpacing: 0.05 * fs(14.0),
                  color: const Color(0xFFA0A3B1),
                ),
              ),
            ),
          ),

          // Pause Button
          Positioned(
            left: w(152.48),
            top: h(528.49),
            width: w(109.04727935791016),
            height: h(109.03512573242188),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/musicV2pause.svg',
                width: w(109),
                height: h(109),
              ),
            ),
          ),

          // Rewind Button
          Positioned(
            left: w(63.7),
            top: h(563.49),
            width: w(38.774600982666016),
            height: h(39.038814544677734),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/icons/musicv2rewind.svg',
                width: w(38.774600982666016),
                height: h(39.038814544677734),
                colorFilter: const ColorFilter.mode(
                  Color(0xFFE6E7F2),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          // Forward Button
          Positioned(
            left: w(311.52),
            top: h(563.49),
            width: w(38.774600982666016),
            height: h(39.038814544677734),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/icons/musicv2forward.svg',
                width: w(38.774600982666016),
                height: h(39.038814544677734),
                colorFilter: const ColorFilter.mode(
                  Color(0xFFE6E7F2),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          // Progress Bar Background
          Positioned(
            left: w(40.28),
            top: h(696.02),
            width: w(333.44),
            child: Container(
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0x80A0A3B1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Progress Bar Filled
          Positioned(
            left: w(40.28),
            top: h(696.02),
            width: w(28.74),
            child: Container(
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0xFF3F414E),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Progress Indicator Circle (outer)
          Positioned(
            left: w(64.48),
            top: h(687.52),
            child: Container(
              width: w(17.0),
              height: h(17.0),
              decoration: BoxDecoration(
                color: const Color(0x403F414E),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Progress Indicator Circle (inner)
          Positioned(
            left: w(66.48),
            top: h(689.52),
            child: Container(
              width: w(13.0),
              height: h(13.0),
              decoration: const BoxDecoration(
                color: Color(0xFF3F414E),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Time Label - 01:30
          Positioned(
            left: w(20.0),
            top: h(716.78),
            width: w(40.56),
            height: h(13.0),
            child: Text(
              '01:30',
              style: TextStyle(
                fontFamily: 'HelveticaNeue',
                fontSize: fs(16.0),
                height: 1.081,
                color: const Color(0xFF3F414E),
              ),
            ),
          ),

          // Time Label - 45:00
          Positioned(
            left: w(353.44),
            top: h(716.78),
            width: w(40.56),
            height: h(13.0),
            child: Text(
              '45:00',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'HelveticaNeue',
                fontSize: fs(16.0),
                height: 1.081,
                color: const Color(0xFF3F414E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;

  const _CircularButton({
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: const Color(0xFFEBEAEC), width: 1),
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Center(child: child),
        ),
      ),
    );
  }
}
