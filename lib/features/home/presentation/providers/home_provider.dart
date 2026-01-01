import 'package:flutter/foundation.dart';
import '../../domain/entities/session.dart';
import '../../domain/usecases/get_sessions_use_case.dart';

class HomeProvider extends ChangeNotifier {
  final GetSessionsUseCase getSessionsUseCase;

  HomeProvider({required this.getSessionsUseCase});

  List<Session> _sessions = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Session> get sessions => _sessions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Fetches data only if the list is empty (Caching logic)
  Future<void> loadData() async {
    if (_sessions.isNotEmpty) return; // Cache hit

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedSessions = await getSessionsUseCase.execute();
      _sessions = List.from(fetchedSessions)..shuffle();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Force refresh if needed (Pull to refresh)
  Future<void> refresh() async {
    _sessions.clear();
    await loadData();
  }

  /// Randomly shuffle the existing sessions
  void shuffle() {
    _sessions.shuffle();
    notifyListeners();
  }
}