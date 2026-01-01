import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import 'package:silent_moon/features/favorites/presentation/screens/favorite_screen.dart';
import 'package:silent_moon/features/home/presentation/screens/home_screen.dart';

import '../../../downloads/presentation/screens/download_screen.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
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
          Positioned(
            left: w(193.7),
            top: h(-2.63),
            width: w(227.45),
            height: h(312.78),
            child: Image.asset(AppAssets.vector, fit: BoxFit.fill),
          ),

          Positioned(
            left: w(327.99),
            top: h(-1.04),
            width: w(95.04),
            height: h(186.21),
            child: Image.asset(AppAssets.vector1, fit: BoxFit.fill),
          ),

          Positioned(
            left: w(-88.182),
            top: h(201.24),
            width: w(209.252),
            height: h(189.51),
            child: Image.asset(AppAssets.vector3, fit: BoxFit.fill),
          ),

          Positioned(
            left: w(253),
            top: h(389.22),
            width: w(209.11),
            height: h(189.51),
            child: Image.asset(AppAssets.vector4, fit: BoxFit.fill),
          ),

          Positioned(
            left: w(-42.77),
            top: h(751.83),
            width: w(191),
            height: h(173.92),
            child: Image.asset(AppAssets.vector5, fit: BoxFit.fill),
          ),

          Positioned(
            left: w(270.78),
            top: h(724.06),
            width: w(242.71),
            height: h(232.66),
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(AppAssets.vector6, fit: BoxFit.fill),
            ),
          ),

          // Top Action Buttons
          Positioned(
            left: w(20.0),
            top: h(50.0),
            child: _CircularButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              backgroundColor: const Color(0xFFE6E7F2),
              child: Icon(
                Icons.arrow_back,
                color: const Color(0xFF3F414E),
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
              backgroundColor: const Color(0xFF03174C),
              child: SvgPicture.asset(
                AppAssets.favorite,
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
                AppAssets.download,
                width: w(55),
                height: h(55),
              ),
            ),
          ),

          // Title - Night Island
          Positioned(
            left: w(82),
            top: h(391.94),
            width: w(250),
            height: h(38.19),
            child: Text(
              'Night Island',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'HelveticaNeue',
                fontWeight: FontWeight.w700,
                fontSize: fs(34.0),
                height: 1.081,
                color: const Color(0xFFE6E7F2),
              ),
            ),
          ),

          // Subtitle - SLEEP MUSIC
          Positioned(
            left: w(156.62),
            top: h(445.49),
            width: w(100.75),
            height: h(13.0),
            child: Text(
              'SLEEP MUSIC',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'HelveticaNeue',
                fontWeight: FontWeight.w400,
                fontSize: fs(14.0),
                height: 1.081,
                letterSpacing: 0.05 * fs(14.0),
                color: const Color(0xFF98A1BD),
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
                AppAssets.pause,
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
                'assets/icons/rewind.svg',
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
                'assets/icons/forward.svg',
                width: w(38.774600982666016),
                height: h(39.038814544677734),
                colorFilter: const ColorFilter.mode(
                  Color(0xFFE6E7F2),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          // Volume bars
          Positioned(
            left: w(197.01),
            top: h(570.55),
            width: w(6.82),
            height: h(24.92),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF3F414E),
                borderRadius: BorderRadius.circular(w(14)),
              ),
            ),
          ),
          Positioned(
            left: w(210.17),
            top: h(570.55),
            width: w(6.82),
            height: h(24.92),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF3F414E),
                borderRadius: BorderRadius.circular(w(14)),
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
                color: const Color(0x8047557E),
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
                color: const Color(0xFFE6E7F2),
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
                color: const Color(0x598E97FD),
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
                color: Color(0xFF8E97FD),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Time Label - 01:30
          Positioned(
            left: w(20.0),
            top: h(716.78),
            width: w(60.0),
            height: h(20.0),
            child: Text(
              '01:30',
              style: TextStyle(
                fontFamily: 'HelveticaNeue',
                fontSize: fs(16.0),
                fontWeight: FontWeight.w400,
                height: 1.081,
                color: const Color(0xFFE6E7F2),
              ),
            ),
          ),

          // Time Label - 45:00
          Positioned(
            left: w(333.44),
            top: h(716.78),
            width: w(60.0),
            height: h(20.0),
            child: Text(
              '45:00',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'HelveticaNeue',
                fontSize: fs(16.0),
                fontWeight: FontWeight.w400,
                height: 1.081,
                color: const Color(0xFFE6E7F2),
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
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
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
