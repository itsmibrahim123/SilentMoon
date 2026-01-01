import 'package:flutter/material.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import 'package:silent_moon/features/home/presentation/screens/home_screen.dart';
import 'package:silent_moon/features/welcome/presentation/screens/welcome_sleep_screen.dart';
import 'package:silent_moon/features/meditation/presentation/screens/meditate_screen.dart';
import 'package:silent_moon/features/sleep/presentation/screens/sleep_music_screen.dart';
import 'package:silent_moon/features/profile/presentation/screens/user_profile_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Color backgroundColor;
  final void Function(int index)? onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.backgroundColor = Colors.white,
  });

  void _defaultNavigate(BuildContext context, int index) {
    Widget target;
    switch (index) {
      case 0:
        target = const HomeScreen();
        break;
      case 1:
        target = const WelcomeSleepScreen();
        break;
      case 2:
        target = const MeditateScreen();
        break;
      case 3:
        target = const SleepMusicScreen();
        break;
      case 4:
        target = const UserProfileScreen();
      default:
        target = const HomeScreen();
    }
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, a, b) => target,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  BottomNavigationBarItem _item({
    required String asset,
    required String label,
    required bool isActive,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        asset,
        width: 24,
        height: 24,
        color: isActive ? const Color(0xFF8E97FD) : Colors.grey,
      ),
      activeIcon: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: const Color(0xFF8E97FD).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Image.asset(
            asset,
            width: 24,
            height: 24,
            color: const Color(0xFF8E97FD),
          ),
        ),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 12,
              spreadRadius: 0,
              offset: Offset(0, -6), // shadow above the bar
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedItemColor: const Color(0xFF8E97FD),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'HelveticaNeue',
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'HelveticaNeue',
            fontSize: 12,
          ),
          onTap: (index) {
            if (onItemTapped != null) {
              onItemTapped!(index);
            } else {
              _defaultNavigate(context, index);
            }
          },
          items: [
            _item(
              asset: 'assets/images/Vector.png',
              label: 'Home',
              isActive: selectedIndex == 0,
            ),
            _item(
              asset: 'assets/images/Vector-1.png',
              label: 'Sleep',
              isActive: selectedIndex == 1,
            ),
            _item(
              asset: AppAssets.group,
              label: 'Meditate',
              isActive: selectedIndex == 2,
            ),
            _item(
              asset: 'assets/images/Group-1.png',
              label: 'Music',
              isActive: selectedIndex == 3,
            ),
            _item(
              asset: 'assets/images/Group-2.png',
              label: 'Afsar',
              isActive: selectedIndex == 4,
            ),
          ],
        ),
      ),
    );
  }
}
