import 'package:flutter/foundation.dart';
import '../../domain/entities/track.dart';
import '../../domain/usecases/get_tracks_use_case.dart';

class SleepProvider extends ChangeNotifier {
  final GetTracksUseCase getTracksUseCase;

  SleepProvider({required this.getTracksUseCase});

  List<Track> _tracks = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Track> get tracks => _tracks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Fetches data only if the list is empty (Caching logic)
  Future<void> loadData() async {
    if (_tracks.isNotEmpty) return; // Cache hit

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _tracks = await getTracksUseCase.execute();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Force refresh if needed
  Future<void> refresh() async {
    _tracks.clear();
    await loadData();
  }
}
