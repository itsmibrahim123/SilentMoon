import '../entities/session.dart';
import '../repositories/i_session_repository.dart';

class GetSessionsUseCase {
  final ISessionRepository repository;

  GetSessionsUseCase(this.repository);

  Future<List<Session>> execute() {
    return repository.getSessions();
  }
}