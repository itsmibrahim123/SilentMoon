import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silent_moon/core/constants/app_colors.dart';
import 'package:silent_moon/core/widgets/bottom_nav_bar.dart';

import '../../data/datasources/download_remote_data_source.dart';
import '../../data/repositories/download_repository_impl.dart';
import '../../domain/entities/download.dart';
import '../../domain/usecases/get_downloads_use_case.dart';
import '../providers/download_provider.dart';

import '../../../home/presentation/pages/home_screen.dart';
import '../../../meditation/presentation/pages/meditate_screen.dart';
import '../../../profile/presentation/pages/user_profile_screen.dart';
import '../../../sleep/presentation/pages/sleep_music_screen.dart';
import '../../../sleep/presentation/pages/sleep_screen.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  int _selectedNavIndex = 4;

  void _onItemTapped(int index) {
    if (_selectedNavIndex == index) return;
    setState(() => _selectedNavIndex = index);

    if (index == 0) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(pageBuilder: (_, _, _) => const HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(pageBuilder: (_, _, _) => const SleepScreen()),
      );
    } else if (index == 2) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(pageBuilder: (_, _, _) => const MeditateScreen()),
      );
    } else if (index == 3) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(pageBuilder: (_, _, _) => const SleepMusicScreen()),
      );
    } else if (index == 4) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(pageBuilder: (_, _, _) => const UserProfileScreen()),
      );
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
      create: (_) => DownloadProvider(
        getDownloadsUseCase: GetDownloadsUseCase(
          DownloadRepositoryImpl(
            remoteDataSource: DownloadRemoteDataSourceImpl(
              auth: FirebaseAuth.instance,
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
        toggleDownloadUseCase: context
            .read<DownloadProvider>()
            .toggleDownloadUseCase,
      )..loadData(),
      child: Scaffold(
        backgroundColor: const Color(0xFF03174C),
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w(20),
                  vertical: h(20),
                ),
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
                            color: const Color(
                              0xFFE6E7F2,
                            ).withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.textPrimary,
                          size: w(20),
                        ),
                      ),
                    ),
                    Text(
                      'Downloads',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.bold,
                        fontSize: fs(28),
                        color: AppColors.textLight,
                      ),
                    ),
                    SizedBox(width: w(55), height: w(55)),
                  ],
                ),
              ),
              // List
              Expanded(
                child: Consumer<DownloadProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (provider.downloads.isEmpty) {
                      return const Center(
                        child: Text(
                          "No downloads yet",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: w(20),
                        vertical: h(10),
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 177 / 177,
                        crossAxisSpacing: w(15),
                        mainAxisSpacing: h(15),
                      ),
                      itemCount: provider.downloads.length,
                      itemBuilder: (context, index) {
                        return _DownloadCard(
                          item: provider.downloads[index],
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
          backgroundColor: const Color(0xFF03174D),
        ),
      ),
    );
  }
}

class _DownloadCard extends StatelessWidget {
  final Download item;
  final double Function(double) w;
  final double Function(double) h;
  final double Function(double) fs;

  const _DownloadCard({
    required this.item,
    required this.w,
    required this.h,
    required this.fs,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = const Color(0xFF586894);
    try {
      if (item.color.isNotEmpty && item.color.startsWith('#')) {
        bgColor = Color(
          int.parse(item.color.substring(1, 7), radix: 16) + 0xFF000000,
        );
      }
    } catch (_) {}

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(w(10)),
              image: item.imageUrl.isNotEmpty
                  ? DecorationImage(
                      image: AssetImage(item.imageUrl),
                      fit: BoxFit.cover,
                      onError: (_, _) {},
                    )
                  : null,
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: h(10),
                  right: w(10),
                  child: Container(
                    width: w(30),
                    height: w(30),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF6CB28E), // Green
                    ),
                    child: Icon(
                      Icons.check_circle,
                      size: w(20),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: h(10)),
        Text(
          item.title,
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.bold,
            fontSize: fs(18),
            color: AppColors.textLight,
          ),
        ),
        SizedBox(height: h(5)),
        Text(
          item.subtitle,
          style: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.w400,
            fontSize: fs(11),
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
