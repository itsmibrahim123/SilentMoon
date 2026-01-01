import 'package:flutter/material.dart';
import 'package:silent_moon/core/constants/app_colors.dart';
import 'package:silent_moon/core/constants/app_typography.dart';

/// A shared, reusable BottomNavigationBar that keeps behavior identical across screens.
/// Background color is configurable via [backgroundColor].
class SharedBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color backgroundColor;

  const SharedBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor = AppColors.backgroundWhite,
  });

  BottomNavigationBarItem _item({
    required String asset,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        asset,
        width: 24,
        height: 24,
        color: AppColors.textLight,
      ),
      activeIcon: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: AppColors.faintWhite40,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Image.asset(
          asset,
          width: 24,
          height: 24,
          color: AppColors.primaryPurple,
        ),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: BottomNavigationBar(
        backgroundColor: backgroundColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTap,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.primaryPurple,
        unselectedItemColor: AppColors.textLight,
        selectedLabelStyle: AppTypography.caption,
        unselectedLabelStyle: AppTypography.caption,
        AppAseetsl
        items: <BottomNavigationBarItem>[
          _item(asset: 'assets/images/Vector.png', label: 'Home'),
          _item(asset: 'assets/images/Vector-1.png', label: 'Sleep'),
          _item(asset: 'assets/images/Group.png', label: 'Meditate'),
          _item(asset: 'assets/images/Group-1.png', label: 'Music'),
          _item(asset: 'assets/images/Group-2.png', label: 'Afsar'),
        ],
      ),
    );
  }
}
