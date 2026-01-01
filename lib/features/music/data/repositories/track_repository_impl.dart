import '../../domain/repository/i_track_repository.dart';
import '../../domain/entities/track.dart';
import '../datasources/track_remote_data_source.dart';

class TrackRepositoryImpl implements ITrackRepository {
  final TrackRemoteDataSource remoteDataSource;

  TrackRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Track?> getTrackStream(String trackId) {
    return remoteDataSource.getTrackStream(trackId);
  }
}

