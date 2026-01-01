import '../../domain/entities/session.dart';
import '../../domain/repositories/i_session_repository.dart';
import '../datasources/session_remote_data_source.dart';

class SessionRepositoryImpl implements ISessionRepository {
  final SessionRemoteDataSource remoteDataSource;

  SessionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Session>> getSessions() async {
    return await remoteDataSource.getSessions();
  }
}