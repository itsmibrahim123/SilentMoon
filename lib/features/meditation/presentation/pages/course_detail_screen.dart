import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:silent_moon/features/music/presentation/pages/music_v2_screen.dart';
import '../../../../features/home/domain/entities/session.dart';
import '../../../user/presentation/providers/user_provider.dart';

class CourseDetailScreen extends StatefulWidget {
  final Session session;

  const CourseDetailScreen({super.key, required this.session});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool isMaleVoice = true;
  int activeSessionIndex = -1; // Track which session is active

  void _openMusicV2Screen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MusicV2Screen(
          trackId: 'track_gen_1', // TODO: Replace with actual track ID from session
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    // Reference: 414 x 896
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    final userProvider = context.watch<UserProvider>();
    final isFav = userProvider.isFavorite(widget.session.id);
    final isDownloaded = userProvider.isDownloaded(widget.session.id);

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
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
                      AppAssets.sun,
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
                    // Title
                    Text(
                      widget.session.title,
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w700,
                        fontSize: fs(34.0),
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: h(10.0)),
                    // Subtitle
                    Text(
                      widget.session.subtitle,
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w400,
                        fontSize: fs(14.0),
                        letterSpacing: 0.05 * fs(14.0),
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: h(15.0)),
                    // Description (Placeholder or add to Session entity)
                    Text(
                      'Ease the mind into a restful night’s sleep with these deep, amblent tones.',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w300,
                        fontSize: fs(16.0),
                        height: 1.45,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: h(30.0)),
                    // Stats
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.like,
                          width: w(20.0),
                          height: h(18.0),
                          colorFilter: const ColorFilter.mode(
                            AppColors.accentPink,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: w(10.0)),
                        Text(
                          '24.234 Favorites',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontSize: fs(14.0),
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(width: w(30.0)),
                        Image.asset(
                          AppAssets.headphones,
                          width: w(20.0),
                          height: h(18.0),
                          color: AppColors.accentBlue,
                        ),
                        SizedBox(width: w(10.0)),
                        Text(
                          '34.234 Listening',
                          style: TextStyle(
                            fontFamily: 'HelveticaNeue',
                            fontSize: fs(14.0),
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h(40.0)),
                    // Narrator Section
                    Text(
                      'Pick a Narrator',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w700,
                        fontSize: fs(20.0),
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: h(30.0)),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => isMaleVoice = true),
                          child: Text(
                            'MALE VOICE',
                            style: TextStyle(
                              fontFamily: 'HelveticaNeue',
                              fontSize: fs(16.0),
                              letterSpacing: 0.05 * fs(16.0),
                              color: isMaleVoice
                                  ? AppColors.primaryPurple
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                        SizedBox(width: w(70.0)),
                        GestureDetector(
                          onTap: () => setState(() => isMaleVoice = false),
                          child: Text(
                            'FEMALE VOICE',
                            style: TextStyle(
                              fontFamily: 'HelveticaNeue',
                              fontSize: fs(16.0),
                              letterSpacing: 0.05 * fs(16.0),
                              color: !isMaleVoice
                                  ? AppColors.primaryPurple
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h(15.0)),
                    Stack(
                      children: [
                        Container(
                          height: 2,
                          width: double.infinity,
                          color: AppColors.primaryLight,
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          left: isMaleVoice ? 0 : w(174.0),
                          child: Container(
                            height: 2,
                            width: w(isMaleVoice ? 104.03 : 126.32),
                            color: AppColors.primaryPurple,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h(20.0)),
                    // Session List (Static for now as sub-sessions aren't in entity yet)
                    _SessionListItem(
                      icon: activeSessionIndex == 0
                          ? AppAssets.playBlue
                          : AppAssets.playIcon,
                      title: 'Focus Attention',
                      duration: '10 MIN',
                      isActive: activeSessionIndex == 0,
                      onTap: () {
                        setState(() => activeSessionIndex = 0);
                        _openMusicV2Screen();
                      },
                    ),
                    _SessionListItem(
                      icon: activeSessionIndex == 1
                          ? AppAssets.playBlue
                          : AppAssets.playIcon,
                      title: 'Body Scan',
                      duration: '5 MIN',
                      isActive: activeSessionIndex == 1,
                      onTap: () {
                        setState(() => activeSessionIndex = 1);
                        _openMusicV2Screen();
                      },
                    ),
                    _SessionListItem(
                      icon: activeSessionIndex == 2
                          ? AppAssets.playBlue
                          : AppAssets.playIcon,
                      title: 'Making Happiness',
                      duration: '3 MIN',
                      isActive: activeSessionIndex == 2,
                      onTap: () {
                        setState(() => activeSessionIndex = 2);
                        _openMusicV2Screen();
                      },
                    ),
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
                ),
                Row(
                  children: [
                    // Favorite Icon with light background
                    Container(
                      width: 60, // Adjustable size
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black, // very light background
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Transform.rotate(
                        angle: 0, // -180deg in radians
                        child: Opacity(
                          opacity: 0.9,
                          child: _CircularButton(
                            onPressed: () {
                              context
                                  .read<UserProvider>()
                                  .toggleFavorite(widget.session.id, 'session');
                            },
                            icon: isFav ? Icons.favorite : Icons.favorite_border,
                            customColor: isFav ? Colors.red : null,
                            size: 55, // Match download icon size
                            iconSize: 100, // Make icon bigger
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: w(10.0)),
                    // Download Icon with light background
                    Container(
                      width: 60, // Adjustable size
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black, // very light background
                        borderRadius: BorderRadius.circular(38),
                      ),
                      child: Transform.rotate(
                        angle: 0, // -180deg in radians
                        child: Opacity(
                          opacity: 0.9,
                          child: _CircularButton(
                            onPressed: () {
                              context
                                  .read<UserProvider>()
                                  .toggleDownload(widget.session.id, 'session');
                            },
                            icon: isDownloaded
                                ? Icons.download_done
                                : Icons.download_outlined,
                            customColor: isDownloaded ? Colors.green : null,
                            size: 55, // Make button bigger
                            iconSize: 100, // Make icon bigger
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
  final VoidCallback onPressed;
  final double size;
  final double iconSize;
  final Color? customColor;

  const _CircularButton({
    this.icon,
    this.iconAsset,
    required this.onPressed,
    this.size = 48,
    this.iconSize = 22,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: icon != null
                ? Icon(
                    icon,
                    color: customColor ?? const Color(0xFF3F414E),
                    size: iconSize,
                  )
                : iconAsset != null && iconAsset!.endsWith('.svg')
                ? SvgPicture.asset(
                    iconAsset!,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryLight,
                      BlendMode.srcIn,
                    ),
                    width: iconSize,
                    height: iconSize,
                  )
                : iconAsset != null
                ? Image.asset(
                    iconAsset!,
                    color: const Color(0xFFE6E7F2),
                    width: iconSize,
                    height: iconSize,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class _SessionListItem extends StatelessWidget {
  final String icon;
  final String title;
  final String duration;
  final bool isActive;
  final VoidCallback onTap;

  const _SessionListItem({
    required this.icon,
    required this.title,
    required this.duration,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double circleSize = 55; // Match play_option_screen
    const double iconSize = 55; // Match play_option_screen

    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundWhite, // No blue background
                  border: Border.all(
                    color: AppColors.textSecondary,
                    width: 1.2,
                  ),
                ),
                child: Center(
                  child: icon.endsWith('.svg')
                      ? SvgPicture.asset(
                          icon,
                          width: iconSize,
                          height: iconSize,
                        )
                      : Image.asset(icon, width: iconSize, height: iconSize),
                ),
              ),
            ),
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'HelveticaNeue',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF3F414E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: const TextStyle(
                    fontFamily: 'HelveticaNeue',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFFA1A4B2),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (!isActive)
          Container(
            height: 1,
            color: AppColors.textLight.withValues(alpha: 0.15),
          ),
      ],
    );
  }
}