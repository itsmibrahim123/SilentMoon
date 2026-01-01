import '../entities/favorite.dart';
import '../repositories/i_favorite_repository.dart';

class ToggleFavoriteUseCase {
  final IFavoriteRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<void> execute(Favorite favorite) {
    return repository.toggleFavorite(favorite);
  }
}
