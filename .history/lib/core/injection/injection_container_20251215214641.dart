import 'package:get_it/get_it.dart';

/// Dependency injection container
final sl = GetIt.instance;

/// Initialize dependency injection
Future<void> init() async {
  // Example:
  // sl.registerLazySingleton(() => AuthRepositoryImpl(sl()));
  // sl.registerLazySingleton<AuthRepository>(() => sl<AuthRepositoryImpl>());
}
