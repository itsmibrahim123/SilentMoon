import 'package:flutter/material.dart';
import 'package:silent_moon/core/constants/app_colors.dart';
import 'package:silent_moon/core/constants/app_typography.dart';
import 'package:silent_moon/core/widgets/shared_bottom_nav.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isLandscape = media.orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        title: Text(
          'Sample',
          style: AppTypography.h2.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxW = constraints.maxWidth;
          final horizontalPadding = maxW > 600 ? 32.0 : 16.0;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning, Afsar',
                  style: AppTypography.h1.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'We wish you have a good day',
                  style: AppTypography.subtitle1.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _Card(
                        title: 'Basics',
                        subtitle: 'COURSE',
                        minutes: '3-10 MIN',
                        background: AppColors.cardPurple,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _Card(
                        title: 'Relaxation',
                        subtitle: 'MUSIC',
                        minutes: '3-10 MIN',
                        background: AppColors.accentOrange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Recommended for you',
                  style: AppTypography.h2.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Flex(
                  direction: isLandscape ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _SmallCard(
                        title: 'Focus',
                        background: AppColors.accentGreen,
                      ),
                    ),
                    const SizedBox(width: 12, height: 12),
                    Expanded(
                      child: _SmallCard(
                        title: 'Happiness',
                        background: AppColors.accentYellow,
                      ),
                    ),
                    const SizedBox(width: 12, height: 12),
                    Expanded(
                      child: _SmallCard(
                        title: 'Performance',
                        background: AppColors.cardDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const SharedBottomNav(
        currentIndex: 0,
        onTap: _noop,
        backgroundColor: AppColors.backgroundWhite,
      ),
    );
  }
}

void _noop(int _) {}

class _Card extends StatelessWidget {
  final String title;
  final String subtitle;
  final String minutes;
  final Color background;

  const _Card({
    required this.title,
    required this.subtitle,
    required this.minutes,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.h2.copyWith(color: AppColors.textWhite),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppTypography.caption.copyWith(
              color: AppColors.faintWhite40,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.borderLight,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              'START',
              style: AppTypography.caption.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallCard extends StatelessWidget {
  final String title;
  final Color background;

  const _SmallCard({required this.title, required this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          title,
          style: AppTypography.h2.copyWith(color: AppColors.backgroundWhite),
        ),
      ),
    );
  }
}
