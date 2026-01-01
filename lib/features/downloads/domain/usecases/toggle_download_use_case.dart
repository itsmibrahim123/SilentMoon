import '../entities/download.dart';
import '../repositories/i_download_repository.dart';

class ToggleDownloadUseCase {
  final IDownloadRepository repository;

  ToggleDownloadUseCase(this.repository);

  Future<void> call(Download download) {
    return repository.toggleDownload(download);
  }
}