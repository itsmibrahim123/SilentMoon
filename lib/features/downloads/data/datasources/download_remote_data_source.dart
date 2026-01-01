import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/download_model.dart';
import '../../domain/entities/download.dart';

abstract class DownloadRemoteDataSource {
  Future<List<Download>> getDownloads();
  Future<void> toggleDownload(Download download);
}

class DownloadRemoteDataSourceImpl implements DownloadRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  DownloadRemoteDataSourceImpl({
    required this.auth,
    required this.firestore,
  });

  @override
  Future<List<Download>> getDownloads() async {
    final user = auth.currentUser;
    if (user == null) return [];
    
    final snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('downloads')
        .get();

    return snapshot.docs.map((doc) => DownloadModel.fromSnapshot(doc)).toList();
  }

  @override
  Future<void> toggleDownload(Download download) async {
    final user = auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final ref = firestore
        .collection('users')
        .doc(user.uid)
        .collection('downloads')
        .doc(download.id);

    final doc = await ref.get();
    if (doc.exists) {
      await ref.delete();
    } else {
      final model = DownloadModel(
        id: download.id,
        title: download.title,
        subtitle: download.subtitle,
        imageUrl: download.imageUrl,
        color: download.color,
        localPath: download.localPath,
      );
      await ref.set({
        'title': model.title,
        'subtitle': model.subtitle,
        'imageUrl': model.imageUrl,
        'color': model.color,
        'localPath': model.localPath,
        'addedAt': FieldValue.serverTimestamp(),
      });
    }
  }
}