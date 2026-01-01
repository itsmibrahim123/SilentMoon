import '../entities/track.dart';

abstract class ITrackRepository {
  Stream<Track?> getTrackStream(String trackId);
}

