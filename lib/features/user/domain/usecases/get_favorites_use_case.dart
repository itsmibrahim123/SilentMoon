import 'package:dartz/dartz.dart';
import '../repositories/i_user_repository.dart';

class GetFavoritesUseCase {
  final IUserRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<Either<String, List<String>>> call() {
    return repository.getFavorites();
  }
}
