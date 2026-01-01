import 'package:flutter/material.dart';

/// Shared bottom navigation bar used across sleep/meditation flow.
class BottomNavbarNavigation extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;
  final bool isDark;

  const BottomNavbarNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFF8E97FD);
    final Color inactiveColor = isDark ? const Color(0xFF98A1BD) : Colors.grey;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      showUnselectedLabels: true,
      selectedItemColor: activeColor,
      unselectedItemColor: inactiveColor,
      selectedLabelStyle: const TextStyle(
        fontFamily: 'HelveticaNeue',
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'HelveticaNeue',
        fontSize: 12,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bedtime_outlined),
          activeIcon: Icon(Icons.bedtime),
          label: 'Sleep',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.self_improvement_outlined),
          activeIcon: Icon(Icons.self_improvement),
          label: 'Meditate',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music_outlined),
          activeIcon: Icon(Icons.library_music),
          label: 'Music',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
