import 'package:get_it/get_it.dart';

/// Dependency injection container
final sl = GetIt.instance;

/// Initialize dependency injection
Future<void> init() async {
  // TODO: Register dependencies here when backend is implemented
  // Example:
  // sl.registerLazySingleton(() => AuthRepositoryImpl(sl()));
  // sl.registerLazySingleton<AuthRepository>(() => sl<AuthRepositoryImpl>());
}
