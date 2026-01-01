import '../entities/track.dart';
import '../repositories/i_track_repository.dart';

class GetTracksUseCase {
  final ITrackRepository repository;

  GetTracksUseCase(this.repository);

  Future<List<Track>> execute() {
    return repository.getTracks();
  }
}