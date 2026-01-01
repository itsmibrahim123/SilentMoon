import 'package:dartz/dartz.dart';
import '../../domain/repositories/i_user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements IUserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, void>> toggleFavorite(Map<String, dynamic> data) async {
    try {
      await remoteDataSource.toggleFavorite(data);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> toggleDownload(Map<String, dynamic> data) async {
    try {
      await remoteDataSource.toggleDownload(data);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<String>>> getFavorites() async {
    try {
      final result = await remoteDataSource.getFavorites();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<String>>> getDownloads() async {
    try {
      final result = await remoteDataSource.getDownloads();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
