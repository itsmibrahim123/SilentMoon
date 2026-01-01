import '../entities/track.dart';

abstract class ITrackRepository {
  Future<List<Track>> getTracks();
}