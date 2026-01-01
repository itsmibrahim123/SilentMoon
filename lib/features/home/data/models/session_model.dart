import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/session.dart';

class SessionModel extends Session {
  SessionModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.duration,
    required super.imageUrl,
    required super.audioUrl,
  });

  factory SessionModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SessionModel(
      id: doc.id,
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      duration: data['duration'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      audioUrl: data['audioUrl'] ?? '',
    );
  }
}
