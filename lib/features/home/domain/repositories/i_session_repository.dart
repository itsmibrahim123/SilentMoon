import '../entities/session.dart';

abstract class ISessionRepository {
  Future<List<Session>> getSessions();
}
