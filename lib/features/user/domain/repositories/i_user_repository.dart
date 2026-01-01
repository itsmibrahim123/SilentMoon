import 'package:dartz/dartz.dart';

abstract class IUserRepository {
  Future<Either<String, void>> toggleFavorite(Map<String, dynamic> data);
  Future<Either<String, void>> toggleDownload(Map<String, dynamic> data);
  Future<Either<String, List<String>>> getFavorites();
  Future<Either<String, List<String>>> getDownloads();
}
