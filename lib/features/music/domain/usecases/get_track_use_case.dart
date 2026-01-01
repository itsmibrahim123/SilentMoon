import '../entities/track.dart';
import '../repository/i_track_repository.dart';

class GetTrackUseCase {
  final ITrackRepository repository;

  GetTrackUseCase(this.repository);

  Stream<Track?> call(String trackId) {
    return repository.getTrackStream(trackId);
  }
}

