import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:silent_moon/core/widgets/bottom_nav_bar.dart';
import '../../../home/presentation/pages/home_screen.dart';
import 'sleep_screen.dart';
import '../../../meditation/presentation/pages/meditate_screen.dart';
import '../utils/app_colors.dart';
import '../../../music/presentation/pages/music_screen.dart';
import '../../../profile/presentation/pages/user_profile_screen.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import '../../domain/entities/track.dart';
import '../../../user/presentation/providers/user_provider.dart';

class SleepMusicScreen extends StatefulWidget {
  const SleepMusicScreen({super.key});

  @override
  State<SleepMusicScreen> createState() => _SleepMusicScreenState();
}

class _SleepMusicScreenState extends State<SleepMusicScreen> {
  int _selectedIndex = 3; // Music tab index with Play at center

  final List<Track> _musicItems = [
    Track(
      id: '1',
      trackType: 'MUSIC',
      title: 'Night Island',
      author: 'Sleep Music',
      imageUrl: AppAssets.night,
      audioUrl: '',
    ),
    Track(
      id: '2',
      trackType: 'MUSIC',
      title: 'Sweet Sleep',
      author: 'Sleep Music',
      imageUrl: AppAssets.goodNight,
      audioUrl: '',
    ),
    Track(
      id: '3',
      trackType: 'MUSIC',
      title: 'Good Night',
      author: 'Sleep Music',
      imageUrl: AppAssets.goodNight,
      audioUrl: '',
    ),
    Track(
      id: '4',
      trackType: 'MUSIC',
      title: 'Moon Clouds',
      author: 'Sleep Music',
      imageUrl: AppAssets.moonClouds,
      audioUrl: '',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const HomeScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const SleepScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const MeditateScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 3) {
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const UserProfileScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // CSS: background: #03174C;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    // Reference: 414 x 896
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: Stack(
        children: [
          SafeArea(
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
                      // Sleep Music text (Centered)
                      Expanded(
                        child: Text(
                          'Sleep Music',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold,
                            fontSize: fs(28),
                            color: AppColors
                                .lightBlueText, // Light text for dark mode
                          ),
                        ),
                      ),
                      // Placeholder to balance the row for centering
                      SizedBox(width: w(55), height: w(55)),
                    ],
                  ),
                ),

                // Grid of Music Cards
                Expanded(
                  child: Consumer<UserProvider>(
                    builder: (context, userProvider, child) {
                      return GridView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: w(20),
                          vertical: h(10),
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:
                              177 / 177, // Square-ish based on width 177
                          crossAxisSpacing: w(15),
                          mainAxisSpacing: h(15),
                        ),
                        itemCount: _musicItems.length,
                        itemBuilder: (context, index) {
                          final item = _musicItems[index];
                          return _buildMusicCard(item, w, h, fs, userProvider);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        backgroundColor: const Color(0xFF03174D),
      ),
    );
  }

  Widget _buildMusicCard(
    Track item,
    double Function(double) w,
    double Function(double) h,
    double Function(double) fs,
    UserProvider userProvider,
  ) {
    final isFavorite = userProvider.isFavorite(item.id);
    final isDownloaded = userProvider.isDownloaded(item.id);

    return GestureDetector(
      onTap: () {
        // Map track ID to Firestore document ID
        final firestoreTrackId = item.id.startsWith('track') 
            ? item.id 
            : 'track_gen_${item.id}';
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicScreen(trackId: firestoreTrackId),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF586894), // Default color
                borderRadius: BorderRadius.circular(
                  w(10),
                ), // CSS: border-radius: 10px
                image: DecorationImage(
                  image: AssetImage(item.imageUrl),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    // Fallback if image doesn't exist
                  },
                ),
              ),
              child: Stack(
                children: [
                  // Play button overlay (implied by "Ellipse 1" in CSS)
                  Positioned(
                    bottom: h(10),
                    right: w(10),
                    child: Container(
                      width: w(25),
                      height: w(25),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.faintWhite40,
                        border: Border.all(
                          color: AppColors.whiteText,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.forward,
                          width: w(16),
                          height: w(16),
                          colorFilter: const ColorFilter.mode(
                            AppColors.whiteText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Heart Button
                  Positioned(
                    top: h(10),
                    right: w(10),
                    child: GestureDetector(
                      onTap: () {
                         userProvider.toggleFavorite({
                           'id': item.id,
                           'title': item.title,
                           'author': item.author,
                           'imageUrl': item.imageUrl,
                           'audioUrl': item.audioUrl,
                           'type': 'track',
                           'duration': '10 min', // Default or fetch real duration
                         });
                      },
                      child: Container(
                        padding: EdgeInsets.all(w(5)),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: w(20),
                        ),
                      ),
                    ),
                  ),
                   // Download Button
                  Positioned(
                    top: h(10),
                    left: w(10),
                    child: GestureDetector(
                      onTap: () {
                         userProvider.toggleDownload({
                           'id': item.id,
                           'title': item.title,
                           'author': item.author,
                           'imageUrl': item.imageUrl,
                           'audioUrl': item.audioUrl,
                           'type': 'track',
                           'duration': '10 min',
                         });
                      },
                      child: Container(
                        padding: EdgeInsets.all(w(5)),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isDownloaded ? Icons.download_done : Icons.download,
                          color: isDownloaded ? Colors.green : Colors.white,
                          size: w(20),
                        ),
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
              color: AppColors.lightBlueText, // Dark mode text
            ),
          ),
          SizedBox(height: h(5)),
          Text(
            '${item.author} • ${item.trackType}',
            style: TextStyle(
              fontFamily: 'HelveticaNeue',
              fontWeight: FontWeight.w400,
              fontSize: fs(11),
              color: AppColors.mutedBlueGrey,
            ),
          ),
        ],
      ),
    );
  }
}
