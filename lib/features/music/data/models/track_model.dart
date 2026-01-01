import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/track.dart';

class TrackModel extends Track {
  TrackModel({
    required super.id,
    required super.title,
    required super.author,
    required super.audioUrl,
    required super.imageUrl,
    required super.duration,
  });

  factory TrackModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TrackModel(
      id: doc.id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      audioUrl: data['audioUrl'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      duration: (data['duration'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'duration': duration,
    };
  }
}

