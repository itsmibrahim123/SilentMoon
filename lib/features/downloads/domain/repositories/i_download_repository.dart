import '../entities/download.dart';

abstract class IDownloadRepository {
  Future<List<Download>> getDownloads();
  Future<void> toggleDownload(Download download);
}