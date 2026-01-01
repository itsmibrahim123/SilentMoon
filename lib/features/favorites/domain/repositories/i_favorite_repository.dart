import '../entities/favorite.dart';

abstract class IFavoriteRepository {
  Stream<List<Favorite>> getFavorites();
  Future<void> toggleFavorite(Favorite favorite);
}
