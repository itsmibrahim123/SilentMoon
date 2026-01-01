import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import 'package:silent_moon/core/services/audio_service.dart';
import 'package:silent_moon/features/music/domain/entities/track.dart';
import 'package:silent_moon/features/music/data/datasources/track_remote_data_source.dart';
import 'package:silent_moon/features/music/data/repositories/track_repository_impl.dart';
import 'package:silent_moon/features/music/domain/usecases/get_track_use_case.dart';
import 'package:silent_moon/features/favorites/presentation/pages/favorite_screen.dart';
import 'package:silent_moon/features/home/presentation/pages/home_screen.dart';
import 'package:silent_moon/features/downloads/presentation/pages/download_screen.dart';

class MusicScreen extends StatelessWidget {
  final String trackId;
  
  const MusicScreen({
    super.key,
    required this.trackId,
  });

  static String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    final audioService = AudioService.instance;

    final getTrackUseCase = GetTrackUseCase(
      TrackRepositoryImpl(
        remoteDataSource: TrackRemoteDataSourceImpl(
          firestore: FirebaseFirestore.instance,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF03174C),
      body: StreamBuilder<Track?>(
        stream: getTrackUseCase(trackId),
        builder: (context, firestoreSnapshot) {
          if (firestoreSnapshot.hasData && firestoreSnapshot.data != null) {
            final track = firestoreSnapshot.data!;
            if (audioService.currentTrack?.id != track.id) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                audioService.playTrack(track, context: context);
              });
            }
          }

          if (firestoreSnapshot.hasError) {
            return Center(child: Text('Error: ${firestoreSnapshot.error}'));
          }

          final track = firestoreSnapshot.data;

          return StreamBuilder<PlayerState>(
            stream: audioService.playerStateStream,
            builder: (context, playerStateSnapshot) {
              final isPlaying = playerStateSnapshot.data?.playing ?? false;
              final isLoading = playerStateSnapshot.data?.processingState == ProcessingState.loading;

              return StreamBuilder<Duration>(
                stream: audioService.positionStream,
                builder: (context, positionSnapshot) {
                  final position = positionSnapshot.data ?? Duration.zero;

                  return StreamBuilder<Duration?>(
                    stream: audioService.durationStream,
                    builder: (context, durationSnapshot) {
                      final duration = durationSnapshot.data ?? Duration(seconds: track?.duration ?? 0);

                      return Stack(
                        children: [
                          // Background Vectors
                          Positioned(
                            left: w(193.7),
                            top: h(-2.63),
                            width: w(227.45),
                            height: h(312.78),
                            child: Image.asset(AppAssets.vector2, fit: BoxFit.fill),
                          ),

                          Positioned(
                            left: w(327.99),
                            top: h(-1.04),
                            width: w(95.04),
                            height: h(186.21),
                            child: Image.asset(AppAssets.vector1, fit: BoxFit.fill),
                          ),

                          Positioned(
                            left: w(-88.182),
                            top: h(201.24),
                            width: w(209.252),
                            height: h(189.51),
                            child: Image.asset(AppAssets.vector3, fit: BoxFit.fill),
                          ),

                          Positioned(
                            left: w(253),
                            top: h(389.22),
                            width: w(209.11),
                            height: h(189.51),
                            child: Image.asset(AppAssets.vector4, fit: BoxFit.fill),
                          ),

                          Positioned(
                            left: w(-42.77),
                            top: h(751.83),
                            width: w(191),
                            height: h(173.92),
                            child: Image.asset(AppAssets.vector5, fit: BoxFit.fill),
                          ),

                          Positioned(
                            left: w(270.78),
                            top: h(724.06),
                            width: w(242.71),
                            height: h(232.66),
                            child: Opacity(
                              opacity: 0.5,
                              child: Image.asset(AppAssets.vector6, fit: BoxFit.fill),
                            ),
                          ),

                          // Top Action Buttons
                          Positioned(
                            left: w(20.0),
                            top: h(50.0),
                            child: _CircularButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                                );
                              },
                              backgroundColor: const Color(0xFFE6E7F2),
                              child: Icon(
                                Icons.arrow_back,
                                color: const Color(0xFF3F414E),
                                size: 24,
                              ),
                            ),
                          ),
                          // Favorite Button
                          Positioned(
                            left: w(269.0),
                            top: h(50.0),
                            width: w(55.0),
                            height: h(55.0),
                            child: _CircularButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const FavoriteScreen(),
                                  ),
                                );
                              },
                              backgroundColor: const Color(0xFF03174C),
                              child: SvgPicture.asset(
                                AppAssets.favorite,
                                width: w(55),
                                height: h(55),
                              ),
                            ),
                          ),
                          // Download Button
                          Positioned(
                            left: w(339.0),
                            top: h(50.0),
                            width: w(55.0),
                            height: h(55.0),
                            child: _CircularButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const DownloadScreen(),
                                  ),
                                );
                              },
                              backgroundColor: const Color(0xFF03174C),
                              child: SvgPicture.asset(
                                AppAssets.download,
                                width: w(55),
                                height: h(55),
                              ),
                            ),
                          ),

                          // Title & Author
                          Positioned(
                            left: w(0), top: h(390), width: width,
                            child: Column(
                              children: [
                                Text(track?.title ?? 'Loading...', textAlign: TextAlign.center, style: TextStyle(fontSize: fs(34), color: Colors.white, fontWeight: FontWeight.bold)),
                                Text(track?.author.toUpperCase() ?? '', style: TextStyle(fontSize: fs(14), color: Colors.white70)),
                              ],
                            ),
                          ),

                          // Controls
                          Positioned(
                            left: 0, top: h(530), width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () => audioService.skipBackward(context: context),
                                  icon: SvgPicture.asset(AppAssets.rewind, width: w(40)),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () => audioService.togglePlayPause(context: context),
                                  child: isLoading
                                      ? const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        )
                                      : SvgPicture.asset(
                                          isPlaying ? AppAssets.pause : AppAssets.playIcon,
                                          width: w(100),
                                        ),
                                ),
                                const SizedBox(width: 20),
                                IconButton(
                                  onPressed: () => audioService.skipForward(context: context),
                                  icon: SvgPicture.asset(AppAssets.forward, width: w(40)),
                                ),
                              ],
                            ),
                          ),

                          // Progress Bar
                          Positioned(
                            left: w(40), top: h(700), width: w(334),
                            child: Slider(
                              value: position.inSeconds.toDouble().clamp(0, duration.inSeconds.toDouble()),
                              max: duration.inSeconds.toDouble() > 0 ? duration.inSeconds.toDouble() : 1,
                              onChanged: (v) => audioService.seek(Duration(seconds: v.toInt()), context: context),
                              activeColor: Colors.white,
                              inactiveColor: Colors.white24,
                            ),
                          ),

                          // Time Labels
                          Positioned(
                            left: w(20), top: h(730), right: w(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDuration(position),
                                  style: TextStyle(
                                    fontSize: fs(16.0),
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  formatDuration(duration),
                                  style: TextStyle(
                                    fontSize: fs(16.0),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}



class _CircularButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  const _CircularButton({required this.onPressed, required this.child, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55, height: 55,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: InkWell(onTap: onPressed, child: Center(child: child)),
    );
  }
}