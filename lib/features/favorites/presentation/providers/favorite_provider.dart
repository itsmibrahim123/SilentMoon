import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/entities/favorite.dart';
import '../../domain/usecases/get_favorites_use_case.dart';
import '../../domain/usecases/toggle_favorite_use_case.dart';

class FavoriteProvider extends ChangeNotifier {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  List<Favorite> _favorites = [];
  List<Favorite> get favorites => _favorites;
  
  // Set for O(1) lookups
  Set<String> _favoriteIds = {};
  
  StreamSubscription? _subscription;

  FavoriteProvider({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) {
    _init();
  }

  void _init() {
    _subscription = getFavoritesUseCase.execute().listen((data) {
      _favorites = data;
      _favoriteIds = data.map((e) => e.id).toSet();
      notifyListeners();
    });
  }

  bool isFavorite(String id) => _favoriteIds.contains(id);

  Future<void> toggle(Favorite favorite) async {
    // Optimistic update
    final exists = isFavorite(favorite.id);
    if (exists) {
      _favorites.removeWhere((e) => e.id == favorite.id);
      _favoriteIds.remove(favorite.id);
    } else {
      _favorites.insert(0, favorite);
      _favoriteIds.add(favorite.id);
    }
    notifyListeners();

    try {
      await toggleFavoriteUseCase.execute(favorite);
    } catch (e) {
      // Revert on error
      if (exists) {
        _favorites.insert(0, favorite);
        _favoriteIds.add(favorite.id);
      } else {
        _favorites.removeWhere((e) => e.id == favorite.id);
        _favoriteIds.remove(favorite.id);
      }
      notifyListeners();
      debugPrint("Error toggling favorite: $e");
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
