import 'package:dartz/dartz.dart';
import '../repositories/i_user_repository.dart';

class ToggleDownloadUseCase {
  final IUserRepository repository;

  ToggleDownloadUseCase(this.repository);

  Future<Either<String, void>> call(Map<String, dynamic> data) {
    return repository.toggleDownload(data);
  }
}
