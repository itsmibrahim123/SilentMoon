import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/download.dart';

class DownloadModel extends Download {
  DownloadModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.imageUrl,
    required super.color,
    required super.localPath,
  });

  // Mocking fromSnapshot as downloads usually come from local DB (SQFlite/Hive)
  // But complying with "Clean Architecture with Firebase" context, maybe user stores download records in Firestore?
  // Or simply mapping a Firestore doc to this model.
  factory DownloadModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DownloadModel(
      id: doc.id,
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      color: data['color'] ?? '#FFFFFF',
      localPath: data['localPath'] ?? '',
    );
  }
}
