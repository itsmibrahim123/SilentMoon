import 'package:flutter/material.dart';
import '../../../reminders/presentation/pages/reminders_page.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/styles/app_typography.dart';

class ChooseTopicScreen extends StatelessWidget {
  const ChooseTopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    // Reference: 414 x 896
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    // ============================================================
    // 👇 CONFIGURATION SECTION 👇
    // ============================================================

    final double cardWidth = w(176.4); // size.width * 0.4261 -> approx w(176.4)
    final double tallCardHeight = h(210);
    final double shortCardHeight = h(167);

    final double sidePadding = w(20);
    final double cloudTopPosition = h(125.44); // 0.14 * 896
    final double topHeaderSpacing = h(53.76); // 0.06 * 896
    final double textLineSpacing = h(4.48);
    final double subHeaderSpacing = h(17.92);
    final double gridTopSpacing = h(49.28);
    final double bottomPageSpacing = h(44.8);

    final double cardVerticalGap = h(22.4);

    // ============================================================

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Stack(
        children: [
          Positioned(
            top: cloudTopPosition,
            left: 0,
            right: 0,
            child: Image.asset(
              AppAssets.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sidePadding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: topHeaderSpacing),
                    Text(
                      'What Brings you',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            fontSize: fs(28),
                          ),
                    ),
                    SizedBox(height: textLineSpacing),
                    Text(
                      'to Silent Moon?',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w300,
                            color: AppColors.textPrimary,
                            fontSize: fs(28),
                          ),
                    ),
                    SizedBox(height: subHeaderSpacing),
                    Text(
                      'choose a topic to focus on:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFamily: 'HelveticaNeue',
                        color: AppColors.textSecondary,
                        fontSize: fs(16),
                      ),
                    ),
                    SizedBox(height: gridTopSpacing),

                    // GRID ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LEFT COLUMN
                        Column(
                          children: [
                            _TopicCard(
                              title: 'Reduce Stress',
                              color: AppColors.primaryPurple,
                              imagePath: AppAssets.reduceStress,
                              height: tallCardHeight,
                              width: cardWidth,
                              textColor: const Color.fromARGB(
                                255,
                                255,
                                236,
                                204,
                              ),
                              imagePadding: EdgeInsets.zero,
                              w: w,
                              h: h,
                              fs: fs,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RemindersPage(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: cardVerticalGap),

                            _TopicCard(
                              title: 'Increase Happiness',
                              color: AppColors.cardOrange,
                              imagePath: AppAssets.increaseHappiness,
                              height: shortCardHeight,
                              width: cardWidth,
                              textColor: AppColors.textPrimary,
                              imagePadding: EdgeInsets.all(w(15)),
                              w: w,
                              h: h,
                              fs: fs,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RemindersPage(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: cardVerticalGap),

                            _TopicCard(
                              title: 'Personal Growth',
                              color: AppColors.cardGreen,
                              imagePath: AppAssets.personalGrowth,
                              height: tallCardHeight,
                              width: cardWidth,
                              textColor: const Color.fromARGB(
                                255,
                                255,
                                236,
                                204,
                              ),
                              imagePadding: EdgeInsets.zero,
                              w: w,
                              h: h,
                              fs: fs,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RemindersPage(),
                                  ),
                                );
                              },
                            ),

                            SizedBox(height: cardVerticalGap),
                            _TopicCard(
                              title: 'Reduce Stress',
                              color: AppColors.primaryPurple,
                              imagePath: AppAssets.reduceStress,
                              height: tallCardHeight,
                              width: cardWidth,
                              textColor: AppColors.textWhite,
                              imagePadding: EdgeInsets.zero,
                              w: w,
                              h: h,
                              fs: fs,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RemindersPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        // RIGHT COLUMN
                        Column(
                          children: [
                            _TopicCard(
                              title: 'Improve Performance',
                              color: AppColors.accentRed,
                              imagePath: AppAssets.improvePerformance,
                              height: shortCardHeight,
                              width: cardWidth,
                              textColor: AppColors.textWhite,
                              imagePadding: EdgeInsets.all(w(15)),
                              w: w,
                              h: h,
                              fs: fs,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RemindersPage(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: cardVerticalGap),

                            _TopicCard(
                              title: 'Reduce Anxiety',
                              color: AppColors.accentYellow,
                              imagePath: AppAssets.reduceAnxiety,
                              height: tallCardHeight,
                              width: cardWidth,
                              textColor: AppColors.textPrimary,
                              imagePadding: EdgeInsets.zero,
                              w: w,
                              h: h,
                              fs: fs,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RemindersPage(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: cardVerticalGap),

                            _TopicCard(
                              title: 'Better Sleep',
                              color: AppColors.primaryDark,
                              imagePath: AppAssets.betterSleep,
                              height: shortCardHeight,
                              width: cardWidth,
                              textColor: AppColors.textWhite,
                              imagePadding: EdgeInsets.all(w(15)),
                              w: w,
                              h: h,
                              fs: fs,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RemindersPage(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: cardVerticalGap),

                            _TopicCard(
                              title: 'Reduce Stress',
                              color: AppColors.accentBeige,
                              imagePath: AppAssets.lastRight,
                              height: tallCardHeight,
                              width: cardWidth,
                              textColor: AppColors.textWhite,
                              imagePadding: EdgeInsets.zero,
                              w: w,
                              h: h,
                              fs: fs,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RemindersPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: bottomPageSpacing),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final String title;
  final Color color;
  final String imagePath;
  final double height;
  final double width;
  final Color textColor;
  final EdgeInsets imagePadding;
  final VoidCallback? press;
  final double Function(double) w;
  final double Function(double) h;
  final double Function(double) fs;

  const _TopicCard({
    required this.title,
    required this.color,
    required this.imagePath,
    required this.height,
    required this.width,
    required this.textColor,
    required this.imagePadding,
    required this.w,
    required this.h,
    required this.fs,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(w(20)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(w(20)),
        child: Stack(
          children: [
            // 1. IMAGE LAYER
            Positioned(
              top: imagePadding.top,
              left: imagePadding.left,
              right: imagePadding.right,
              bottom: h(40),
              child: imagePath == 'placeholder'
                  ? const Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 50,
                        color: Colors.white38,
                      ),
                    )
                  : Image.asset(imagePath, fit: BoxFit.contain),
            ),

            // 2. TEXT LAYER
            Positioned(
              bottom: h(10),
              left: w(10),
              right: w(10),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fs(16),
                ),
              ),
            ),

            // 3. RIPPLE LAYER
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: press,
                  splashColor: Colors.white.withValues(alpha: 0.3),
                  highlightColor: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}