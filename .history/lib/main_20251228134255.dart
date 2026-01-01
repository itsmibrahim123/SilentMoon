import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'core/theme/app_theme.dart';
import 'features/authentication/presentation/providers/auth_provider.dart';
import 'features/authentication/presentation/widgets/auth_wrapper.dart';
import 'features/downloads/data/datasources/download_remote_data_source.dart';
import 'features/downloads/data/repositories/download_repository_impl.dart';
import 'features/downloads/domain/usecases/get_downloads_use_case.dart';
import 'features/downloads/domain/usecases/toggle_download_use_case.dart';
import 'features/downloads/presentation/providers/download_provider.dart';
import 'firebase_options.dart';
import 'core/utils/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await StorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final auth = FirebaseAuth.instance;
            final firestore = FirebaseFirestore.instance;
            final dataSource = DownloadRemoteDataSourceImpl(
              auth: auth,
              firestore: firestore,
            );
            final repository = DownloadRepositoryImpl(
              remoteDataSource: dataSource,
            );

            return DownloadProvider(
              getDownloadsUseCase: GetDownloadsUseCase(repository),
              toggleDownloadUseCase: ToggleDownloadUseCase(repository),
            );
          },
        ),
      ],
      child: MaterialApp(
        title: 'Silent Moon',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
      ),
    );
  }
}
