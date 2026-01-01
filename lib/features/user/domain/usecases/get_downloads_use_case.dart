import 'package:dartz/dartz.dart';
import '../repositories/i_user_repository.dart';

class GetDownloadsUseCase {
  final IUserRepository repository;

  GetDownloadsUseCase(this.repository);

  Future<Either<String, List<String>>> call() {
    return repository.getDownloads();
  }
}
