import '../../domain/entities/track.dart';
import '../../domain/repositories/i_track_repository.dart';
import '../datasources/track_remote_data_source.dart';

class TrackRepositoryImpl implements ITrackRepository {
  final TrackRemoteDataSource remoteDataSource;

  TrackRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Track>> getTracks() async {
    return await remoteDataSource.getTracks();
  }
}