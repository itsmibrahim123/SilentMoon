import 'package:dartz/dartz.dart';
import '../repositories/i_user_repository.dart';

class ToggleFavoriteUseCase {
  final IUserRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<Either<String, void>> call(Map<String, dynamic> data) {
    return repository.toggleFavorite(data);
  }
}