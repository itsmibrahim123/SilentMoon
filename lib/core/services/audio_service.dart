import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../features/music/domain/entities/track.dart';

/// Singleton service for managing audio playback across the app.
/// Provides a single AudioPlayer instance that can be accessed from anywhere.
class AudioService {
  AudioService._();

  static AudioService? _instance;
  static AudioService get instance {
    _instance ??= AudioService._();
    return _instance!;
  }

  final AudioPlayer _player = AudioPlayer();
  Track? _currentTrack;

  // Getters
  AudioPlayer get player => _player;
  Track? get currentTrack => _currentTrack;

  // Streams exposed for UI to listen to
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  /// Load and play a track
  Future<void> playTrack(Track track, {BuildContext? context}) async {
    try {
      // If it's the same track, just resume if paused
      if (_currentTrack?.id == track.id) {
        if (!_player.playing) {
          await _player.play();
        }
        return;
      }

      // Load new track
      _currentTrack = track;
      await _player.setAsset(track.audioUrl);
      await _player.play();
    } catch (e) {
      _currentTrack = null;
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading audio: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      rethrow;
    }
  }

  /// Pause playback
  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e) {
      // Handle error silently or log it
      debugPrint('Error pausing playback: $e');
    }
  }

  /// Resume playback
  Future<void> resume() async {
    try {
      await _player.play();
    } catch (e) {
      // Handle error silently or log it
      debugPrint('Error resuming playback: $e');
    }
  }

  /// Toggle play/pause
  Future<void> togglePlayPause({BuildContext? context}) async {
    if (_currentTrack == null) return;

    try {
      if (_player.playing) {
        await pause();
      } else {
        await resume();
      }
    } catch (e) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error controlling playback: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Skip forward by 15 seconds
  Future<void> skipForward({BuildContext? context}) async {
    try {
      final currentPosition = _player.position;
      final duration = _player.duration ?? Duration.zero;
      final newPosition = currentPosition + const Duration(seconds: 15);
      await _player.seek(
        newPosition > duration ? duration : newPosition,
      );
    } catch (e) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error skipping forward: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Skip backward by 15 seconds
  Future<void> skipBackward({BuildContext? context}) async {
    try {
      final currentPosition = _player.position;
      final newPosition = currentPosition - const Duration(seconds: 15);
      await _player.seek(
        newPosition < Duration.zero ? Duration.zero : newPosition,
      );
    } catch (e) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error skipping backward: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Seek to a specific position
  Future<void> seek(Duration position, {BuildContext? context}) async {
    try {
      await _player.seek(position);
    } catch (e) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error seeking: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Stop playback and clear current track
  Future<void> stop() async {
    try {
      await _player.stop();
      _currentTrack = null;
    } catch (e) {
      debugPrint('Error stopping playback: $e');
    }
  }

  /// Dispose the audio player (call this when app is closing)
  Future<void> dispose() async {
    await _player.dispose();
  }
}

