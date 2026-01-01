import '../../domain/entities/favorite.dart';
import '../../domain/repositories/i_favorite_repository.dart';
import '../datasources/favorite_remote_data_source.dart';

class FavoriteRepositoryImpl implements IFavoriteRepository {
  final FavoriteRemoteDataSource remoteDataSource;

  FavoriteRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<Favorite>> getFavorites() {
    return remoteDataSource.getFavorites();
  }

  @override
  Future<void> toggleFavorite(Favorite favorite) {
    return remoteDataSource.toggleFavorite(favorite);
  }
}
