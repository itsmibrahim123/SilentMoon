import '../entities/download.dart';
import '../repositories/i_download_repository.dart';

class GetDownloadsUseCase {
  final IDownloadRepository repository;

  GetDownloadsUseCase(this.repository);

  Future<List<Download>> call() {
    return repository.getDownloads();
  }
}