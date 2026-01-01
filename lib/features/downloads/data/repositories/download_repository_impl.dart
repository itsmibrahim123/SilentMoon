import '../../domain/entities/download.dart';
import '../../domain/repositories/i_download_repository.dart';
import '../datasources/download_remote_data_source.dart';

class DownloadRepositoryImpl implements IDownloadRepository {
  final DownloadRemoteDataSource remoteDataSource;

  DownloadRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Download>> getDownloads() {
    return remoteDataSource.getDownloads();
  }

  @override
  Future<void> toggleDownload(Download download) {
    return remoteDataSource.toggleDownload(download);
  }
}