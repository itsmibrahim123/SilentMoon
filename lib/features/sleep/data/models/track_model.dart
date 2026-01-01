import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/track.dart';

class TrackModel extends Track {
  TrackModel({
    required super.id,
    required super.title,
    required super.author,
    required super.trackType,
    required super.imageUrl,
    required super.audioUrl,
  });

  factory TrackModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TrackModel(
      id: doc.id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      trackType: data['trackType'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      audioUrl: data['audioUrl'] ?? '',
    );
  }
}
