import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silent_moon/core/widgets/bottom_nav_bar.dart';
import 'package:silent_moon/core/constants/app_colors.dart'; // Ensure correct import

import '../../data/datasources/favorite_remote_data_source.dart';
import '../../data/repositories/favorite_repository_impl.dart';
import '../../domain/entities/favorite.dart';
import '../../domain/usecases/get_favorites_use_case.dart';
import '../../domain/usecases/toggle_favorite_use_case.dart';
import '../providers/favorite_provider.dart';

import '../../../home/presentation/pages/home_screen.dart';
import '../../../meditation/presentation/pages/meditate_screen.dart';
import '../../../profile/presentation/pages/user_profile_screen.dart';
import '../../../sleep/presentation/pages/sleep_music_screen.dart';
import '../../../sleep/presentation/pages/sleep_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedNavIndex = 4;

  void _onItemTapped(int index) {
    if (_selectedNavIndex == index) return;
    setState(() => _selectedNavIndex = index);

    if (index == 0) {
      Navigator.of(context).pushReplacement(
          PageRouteBuilder(pageBuilder: (_, __, ___) => const HomeScreen()));
    } else if (index == 1) {
      Navigator.of(context).pushReplacement(
          PageRouteBuilder(pageBuilder: (_, __, ___) => const SleepScreen()));
    } else if (index == 2) {
      Navigator.of(context).pushReplacement(
          PageRouteBuilder(pageBuilder: (_, __, ___) => const MeditateScreen()));
    } else if (index == 3) {
      Navigator.of(context).pushReplacement(
          PageRouteBuilder(pageBuilder: (_, __, ___) => const SleepMusicScreen()));
    } else if (index == 4) {
      Navigator.of(context).pushReplacement(
          PageRouteBuilder(pageBuilder: (_, __, ___) => const UserProfileScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    return ChangeNotifierProvider(
      create: (_) => FavoriteProvider(
        getFavoritesUseCase: GetFavoritesUseCase(
          FavoriteRepositoryImpl(
            remoteDataSource: FavoriteRemoteDataSourceImpl(
              auth: FirebaseAuth.instance,
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
        toggleFavoriteUseCase: ToggleFavoriteUseCase(
          FavoriteRepositoryImpl(
            remoteDataSource: FavoriteRemoteDataSourceImpl(
              auth: FirebaseAuth.instance,
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w(20), vertical: h(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: w(55),
                        height: w(55),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.faintBlack10,
                            width: 1,
                          ),
                        ),
                        child: Icon(Icons.arrow_back,
                            color: AppColors.textPrimary, size: w(20)),
                      ),
                    ),
                    Text(
                      'Favorites',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.bold,
                        fontSize: fs(28),
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: w(55), height: w(55)),
                  ],
                ),
              ),
              // List
              Expanded(
                child: Consumer<FavoriteProvider>(
                  builder: (context, provider, child) {
                    if (provider.favorites.isEmpty) {
                      return const Center(child: Text("No favorites yet"));
                    }
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: w(20),
                        vertical: h(10),
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: w(177) / (h(160) + h(50)),
                        crossAxisSpacing: w(15),
                        mainAxisSpacing: h(20),
                      ),
                      itemCount: provider.favorites.length,
                      itemBuilder: (context, index) {
                        final item = provider.favorites[index];
                        return _FavoriteCard(
                          favorite: item,
                          w: w,
                          h: h,
                          fs: fs,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedNavIndex,
          onItemTapped: _onItemTapped,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final Favorite favorite;
  final double Function(double) w;
  final double Function(double) h;
  final double Function(double) fs;

  const _FavoriteCard({
    required this.favorite,
    required this.w,
    required this.h,
    required this.fs,
  });

  @override
  Widget build(BuildContext context) {
    // Parse color safely
    Color bgColor = const Color(0xFF80A4FF);
    try {
      if (favorite.color.isNotEmpty) {
        String hex = favorite.color.replaceAll('#', '');
        if (hex.length == 6) {
          bgColor = Color(int.parse(hex, radix: 16) + 0xFF000000);
        }
      }
    } catch (_) {}

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: h(160),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(w(20)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(w(20)),
            child: Stack(
              children: [
                if (favorite.imageUrl.isNotEmpty)
                  Image.asset(
                    favorite.imageUrl,
                    width: double.infinity,
                    height: h(160),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  ),
                Positioned(
                  top: h(10),
                  right: w(10),
                  child: GestureDetector(
                    onTap: () {
                      context.read<FavoriteProvider>().toggle(favorite);
                    },
                    child: Container(
                      padding: EdgeInsets.all(w(6)),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white30,
                      ),
                      child: Icon(Icons.favorite, color: Colors.red, size: w(20)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: h(10)),
        Text(
          favorite.title,
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.bold,
            fontSize: fs(16),
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          favorite.subtitle,
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.w300,
            fontSize: fs(12),
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}