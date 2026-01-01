import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:silent_moon/core/constants/app_assets.dart';
import 'package:silent_moon/core/services/audio_service.dart';
import 'package:silent_moon/features/music/domain/entities/track.dart';
import 'package:silent_moon/features/music/domain/usecases/get_track_use_case.dart';
import 'package:silent_moon/features/music/data/repositories/track_repository_impl.dart';
import 'package:silent_moon/features/music/data/datasources/track_remote_data_source.dart';
import 'package:silent_moon/features/downloads/presentation/pages/download_screen.dart';
import 'package:silent_moon/features/favorites/presentation/pages/favorite_screen.dart';

class MusicV2Screen extends StatelessWidget {
  final String trackId;

  const MusicV2Screen({
    super.key,
    required this.trackId, // Requirement: Pass the specific ID from the list
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
    final w = (num px) => (px * size.width / 414).toDouble();
    final h = (num px) => (px * size.height / 896).toDouble();
    final fs = (num px) => (px * size.width / 414).toDouble();

    final audioService = AudioService.instance;

    final getTrackUseCase = GetTrackUseCase(
      TrackRepositoryImpl(
        remoteDataSource: TrackRemoteDataSourceImpl(
          firestore: FirebaseFirestore.instance,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F3), // Original light beige background
      body: StreamBuilder<Track?>(
        stream: getTrackUseCase(trackId), // Corrected: removed 'widget.' prefix
        builder: (context, firestoreSnapshot) {
          if (firestoreSnapshot.hasData && firestoreSnapshot.data != null) {
            final track = firestoreSnapshot.data!;
            // Start playback only if it's a new track
            if (audioService.currentTrack?.id != track.id) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                audioService.playTrack(track, context: context);
              });
            }
          }

          final track = firestoreSnapshot.data;

          return StreamBuilder<PlayerState>(
            stream: audioService.playerStateStream,
            builder: (context, playerStateSnapshot) {
              final isPlaying = playerStateSnapshot.data?.playing ?? false;
              final processingState = playerStateSnapshot.data?.processingState;
              final isLoading = processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering;

              return StreamBuilder<Duration>(
                stream: audioService.positionStream,
                builder: (context, positionSnapshot) {
                  final position = positionSnapshot.data ?? Duration.zero;

                  return StreamBuilder<Duration?>(
                    stream: audioService.durationStream,
                    builder: (context, durationSnapshot) {
                      final duration = durationSnapshot.data ??
                          Duration(seconds: track?.duration ?? 0);

                      return Stack(
                        children: [
                          _buildBackground(w, h),
                          _buildTopBar(context, w, h),

                          // Track Info
                          _buildTrackInfo(track, w, h, fs),

                          // Controls
                          _buildControls(context, audioService, isPlaying, isLoading, w, h),

                          // Progress Bar
                          _buildProgressBar(audioService, position, duration, w, h),
                          _buildTimeLabels(position, duration, track, w, h, fs),
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

  // --- UI Components ---

  Widget _buildBackground(Function w, Function h) {
    return Stack(
      children: [
        Positioned(left: w(-24), top: h(-29), child: Image.asset(AppAssets.musicV2Bg1, width: w(210))),
        Positioned(left: w(154), top: h(-29), child: Image.asset(AppAssets.musicV2Bg2, width: w(272))),
        Positioned(left: w(-34), top: h(523), child: Image.asset(AppAssets.musicV2Bg3, width: w(272))),
        Positioned(left: w(234), top: h(666), child: Transform.rotate(angle: -1.23, child: Image.asset(AppAssets.musicV2Bg4, width: w(210)))),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context, Function w, Function h) {
    return Positioned(
      top: h(50.0), left: w(20.0), right: w(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CircularButton(
            onPressed: () => Navigator.pop(context),
            backgroundColor: Colors.white,
            child: const Icon(Icons.close, color: Color(0xFF3F414E)),
          ),
          Row(
            children: [
              _CircularButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoriteScreen())),
                backgroundColor: Colors.white.withOpacity(0.5),
                child: SvgPicture.asset(AppAssets.musicV2Favorite),
              ),
              const SizedBox(width: 15),
              _CircularButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DownloadScreen())),
                backgroundColor: const Color(0xFF03174C),
                child: SvgPicture.asset(AppAssets.musicV2Download),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackInfo(Track? track, Function w, Function h, Function fs) {
    return Positioned(
      top: h(390.0), width: w(414.0),
      child: Column(
        children: [
          Text(
            track?.title ?? 'Loading...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fs(34),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3F414E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            track?.author.toUpperCase() ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fs(14),
              color: const Color(0xFFA0A3B1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(BuildContext context, AudioService service, bool isPlaying, bool isLoading, Function w, Function h) {
    return Positioned(
      top: h(530.0), left: 0, right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: () => service.skipBackward(context: context), icon: SvgPicture.asset(AppAssets.musicV2Rewind)),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () => service.togglePlayPause(context: context),
            child: isLoading
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3F414E)),
                  )
                : SvgPicture.asset(
                    isPlaying ? AppAssets.musicV2Pause : AppAssets.playIcon,
                    width: w(109),
                    height: h(109),
                  ),
          ),
          const SizedBox(width: 20),
          IconButton(onPressed: () => service.skipForward(context: context), icon: SvgPicture.asset(AppAssets.musicV2Forward)),
        ],
      ),
    );
  }

  Widget _buildProgressBar(AudioService service, Duration pos, Duration dur, Function w, Function h) {
    return Positioned(
      top: h(700.0), left: w(40.0), right: w(40.0),
      child: Slider(
        value: pos.inSeconds.toDouble().clamp(0.0, dur.inSeconds.toDouble()),
        max: dur.inSeconds.toDouble() > 0 ? dur.inSeconds.toDouble() : 1.0,
        onChanged: (val) => service.seek(Duration(seconds: val.toInt())),
        activeColor: const Color(0xff000000), // Same purple as "sleep sound 1"
        inactiveColor: Colors.grey.withOpacity(0.3),
      ),
    );
  }

  Widget _buildTimeLabels(Duration pos, Duration dur, Track? track, Function w, Function h, Function fs) {
    return Positioned(
      top: h(730.0), left: w(50.0), right: w(50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatDuration(pos),
            style: TextStyle(
              fontSize: fs(16.0),
              color: const Color(0xff000000), // Same purple as "sleep sound 1"
            ),
          ),
          Text(
            formatDuration(dur),
            style: TextStyle(
              fontSize: fs(16.0),
              color: const Color(0xff000000), // Same purple as "sleep sound 1"
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  const _CircularButton({required this.onPressed, required this.child, this.backgroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55, height: 55,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: InkWell(onTap: onPressed, borderRadius: BorderRadius.circular(55), child: Center(child: child)),
    );
  }
}