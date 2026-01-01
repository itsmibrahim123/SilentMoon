import 'package:flutter/foundation.dart';
import '../../domain/entities/download.dart';
import '../../domain/usecases/get_downloads_use_case.dart';
import '../../domain/usecases/toggle_download_use_case.dart';

class DownloadProvider extends ChangeNotifier {
  final GetDownloadsUseCase getDownloadsUseCase;
  final ToggleDownloadUseCase toggleDownloadUseCase;

  // Fix 2: Constructor now requires toggleDownloadUseCase
  DownloadProvider({
    required this.getDownloadsUseCase,
    required this.toggleDownloadUseCase,
  });

  List<Download> _downloads = [];
  List<Download> get downloads => _downloads;
  Set<String> _downloadIds = {};

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();
    try {
      _downloads = await getDownloadsUseCase.call();
      _downloadIds = _downloads.map((e) => e.id).toSet();
    } catch (e) {
      debugPrint("Error loading downloads: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isDownloaded(String id) => _downloadIds.contains(id);

  Future<void> toggleDownload(Download download) async {
    final exists = isDownloaded(download.id);
    // Optimistic Update
    if (exists) {
      _downloads.removeWhere((e) => e.id == download.id);
      _downloadIds.remove(download.id);
    } else {
      _downloads.add(download);
      _downloadIds.add(download.id);
    }
    notifyListeners();

    try {
      await toggleDownloadUseCase.call(download);
    } catch (e) {
      // Revert on error
      if (exists) {
        _downloads.add(download);
        _downloadIds.add(download.id);
      } else {
        _downloads.removeWhere((e) => e.id == download.id);
        _downloadIds.remove(download.id);
      }
      notifyListeners();
      debugPrint("Error toggling download: $e");
    }
  }
}