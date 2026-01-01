import '../entities/favorite.dart';
import '../repositories/i_favorite_repository.dart';

class GetFavoritesUseCase {
  final IFavoriteRepository repository;

  GetFavoritesUseCase(this.repository);

  Stream<List<Favorite>> execute() {
    return repository.getFavorites();
  }
}
