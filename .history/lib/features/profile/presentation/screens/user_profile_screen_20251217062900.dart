import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../../downloads/presentation/screens/download_screen.dart';
import '../../../favorites/presentation/screens/favorite_screen.dart';
import 'package:silent_moon/core/widgets/bottom_nav_bar.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../meditation/presentation/screens/meditate_screen.dart';
import '../../../meditation/presentation/screens/choose_topic_screen.dart';
import '../../../welcome/presentation/screens/welcome_sleep_screen.dart';
import '../../../sleep/presentation/screens/sleep_music_screen.dart';
import '../../../authentication/presentation/widgets/auth_wrapper.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int _selectedIndex = 4; // Profile tab is index 4

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
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const WelcomeSleepScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 2) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const MeditateScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 3) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const SleepMusicScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 4) {
      // already on profile; do nothing
    }
  }

  // Responsive width and height helpers
  double w(double px) => MediaQuery.of(context).size.width * px / 414;
  double h(double px) => MediaQuery.of(context).size.height * px / 896;
  double fs(double px) => MediaQuery.of(context).size.width * px / 414;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w(24.0), vertical: h(24.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar + Name + Email
              Column(
                children: [
                  Container(
                    width: w(96),
                    height: w(96),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.backgroundWhite,
                      border: Border.all(
                        color: AppColors.backgroundWhite,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: AppColors.backgroundGrey,
                      child: Icon(
                        Icons.person,
                        size: w(44),
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  SizedBox(height: h(16)),
                  Text(
                    auth.user?.displayName ?? 'Guest User',
                    style: const TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.w700,
                    ).copyWith(fontSize: fs(24), color: AppColors.textPrimary),
                  ),
                  SizedBox(height: h(8)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: w(14),
                      vertical: h(8),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundGrey,
                      borderRadius: BorderRadius.circular(w(20)),
                    ),
                    child: Text(
                      auth.user?.email ?? 'No email',
                      style:
                          const TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w400,
                          ).copyWith(
                            fontSize: fs(14),
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: h(32)),

              // View Favorites Button with heart icon
              _buildProfileButton(
                context,
                label: 'View Favorites',
                iconAsset: AppAssets.favorite,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FavoriteScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: h(16)),

              // View Downloaded Button with download icon
              _buildProfileButton(
                context,
                label: 'View Downloaded',
                iconAsset: AppAssets.download,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DownloadScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: h(16)),

              // Edit Profile Button
              SizedBox(
                width: double.infinity,
                height: h(60),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ChooseTopicScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    foregroundColor: AppColors.textWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(w(38)),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Edit Profile',
                    style: const TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.w600,
                    ).copyWith(fontSize: fs(16), letterSpacing: 0.05),
                  ),
                ),
              ),
              SizedBox(height: h(16)),

              // Update Username
              _buildProfileButton(
                context,
                label: 'Update Username',
                // icon asset may not exist; fallback handled below via null
                iconAsset: '',
                onPressed: () => _showUpdateUsernameDialog(context, auth),
              ),
              SizedBox(height: h(12)),

              // Reset Password
              _buildProfileButton(
                context,
                label: 'Reset Password',
                iconAsset: AppAssets.eyeLogo,
                onPressed: () => _showResetPasswordDialog(context, auth),
              ),
              SizedBox(height: h(12)),

              // Delete Account
              _buildProfileButton(
                context,
                label: 'Delete Account',
                iconAsset: AppAssets.tickLogo,
                onPressed: () => _showDeleteAccountDialog(context, auth),
              ),
              SizedBox(height: h(12)),

              // Logout
              _buildProfileButton(
                context,
                label: 'Logout',
                iconAsset: AppAssets.download,
                onPressed: () async {
                  await auth.signOut();
                  if (!mounted) return;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const AuthWrapper()),
                    (route) => false,
                  );
                },
              ),

              SizedBox(height: h(24)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        backgroundColor: AppColors.backgroundWhite,
      ),
    );
  }

  // Helper method to build profile action buttons
  Widget _buildProfileButton(
    BuildContext context, {
    required String label,
    required String iconAsset,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: h(60),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primaryPurple, width: 2),
          foregroundColor: AppColors.primaryPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(w(38)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon rendering with safe fallback
            if (iconAsset.isNotEmpty)
              (iconAsset.endsWith('.svg')
                  ? SvgPicture.asset(
                      iconAsset,
                      width: w(24),
                      height: w(24),
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF8E97FD),
                        BlendMode.srcIn,
                      ),
                    )
                  : Image.asset(
                      iconAsset,
                      width: w(24),
                      height: w(24),
                      color: const Color(0xFF8E97FD),
                    ))
            else
              Icon(Icons.person, size: w(24), color: const Color(0xFF8E97FD)),
            SizedBox(width: w(12)),
            Text(
              label,
              style:
                  const TextStyle(
                    fontFamily: 'HelveticaNeue',
                    fontWeight: FontWeight.w400,
                  ).copyWith(
                    fontSize: fs(16),
                    letterSpacing: 0.05,
                    color: AppColors.primaryPurple,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showUpdateUsernameDialog(
    BuildContext context,
    AuthProvider auth,
  ) async {
    final controller = TextEditingController(
      text: auth.user?.displayName ?? '',
    );

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Update Username'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'New username'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result == null || result.isEmpty) return;

    final success = await auth.updateUsername(displayName: result);
    if (!context.mounted) return;

    final message = success ? 'Username updated' : auth.errorMessage;
    if (message != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _showResetPasswordDialog(
    BuildContext context,
    AuthProvider auth,
  ) async {
    final emailController = TextEditingController(text: auth.user?.email ?? '');

    final email = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Reset Password'),
          content: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(ctx).pop(emailController.text.trim()),
              child: const Text('Send'),
            ),
          ],
        );
      },
    );

    if (email == null || email.isEmpty) return;

    final success = await auth.resetPassword(email: email);
    if (!context.mounted) return;

    final message = success
        ? 'Password reset email sent'
        : auth.errorMessage ?? 'Failed to send reset email';
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _showDeleteAccountDialog(
    BuildContext context,
    AuthProvider auth,
  ) async {
    final emailController = TextEditingController(text: auth.user?.email ?? '');
    final passwordController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'This action is permanent. Please confirm your credentials.',
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    final success = await auth.deleteAccount(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Account deleted')));
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      final message = auth.errorMessage ?? 'Failed to delete account';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
