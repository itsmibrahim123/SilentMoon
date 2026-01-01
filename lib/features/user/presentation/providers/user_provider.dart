import 'package:flutter/foundation.dart';
import '../../domain/usecases/get_downloads_use_case.dart';
import '../../domain/usecases/get_favorites_use_case.dart';
import '../../domain/usecases/toggle_download_use_case.dart';
import '../../domain/usecases/toggle_favorite_use_case.dart'; // Fix 3: Import Added

class UserProvider extends ChangeNotifier {
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final ToggleDownloadUseCase toggleDownloadUseCase;
  final GetFavoritesUseCase getFavoritesUseCase;
  final GetDownloadsUseCase getDownloadsUseCase;

  List<String> _favoriteIds = [];
  List<String> _downloadIds = [];

  List<String> get favoriteIds => _favoriteIds;
  List<String> get downloadIds => _downloadIds;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserProvider({
    required this.toggleFavoriteUseCase,
    required this.toggleDownloadUseCase,
    required this.getFavoritesUseCase,
    required this.getDownloadsUseCase,
  }) {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _isLoading = true;
    notifyListeners();

    final favResult = await getFavoritesUseCase();
    favResult.fold(
      (failure) => _errorMessage = failure,
      (ids) => _favoriteIds = ids,
    );

    final dlResult = await getDownloadsUseCase();
    dlResult.fold(
      (failure) => _errorMessage = failure,
      (ids) => _downloadIds = ids,
    );

    _isLoading = false;
    notifyListeners();
  }

  bool isFavorite(String id) => _favoriteIds.contains(id);

  bool isDownloaded(String id) => _downloadIds.contains(id);

  Future<void> toggleFavorite(Map<String, dynamic> data) async {
    final itemId = data['id'];
    final isFav = isFavorite(itemId);
    
    // Optimistic Update
    if (isFav) {
      _favoriteIds.remove(itemId);
    } else {
      _favoriteIds.add(itemId);
    }
    notifyListeners();

    final result = await toggleFavoriteUseCase(data);

    result.fold(
      (failure) {
        // Revert on failure
        if (isFav) {
          _favoriteIds.add(itemId);
        } else {
          _favoriteIds.remove(itemId);
        }
        _errorMessage = failure;
        notifyListeners();
      },
      (_) {},
    );
  }

  Future<void> toggleDownload(Map<String, dynamic> data) async {
    final itemId = data['id'];
    final isDl = isDownloaded(itemId);

    // Optimistic Update
    if (isDl) {
      _downloadIds.remove(itemId);
    } else {
      _downloadIds.add(itemId);
    }
    notifyListeners();

    final result = await toggleDownloadUseCase(data);

    result.fold(
      (failure) {
        // Revert on failure
        if (isDl) {
          _downloadIds.add(itemId);
        } else {
          _downloadIds.remove(itemId);
        }
        _errorMessage = failure;
        notifyListeners();
      },
      (_) {},
    );
  }
}