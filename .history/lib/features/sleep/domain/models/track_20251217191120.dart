// CORRECT: This imports the official package
import 'package:cloud_firestore/cloud_firestore.dart';

class Track {
  final String id;
  final String trackType; // 'music' or 'sleep_story'
  final String title;
  final String subtitle;
  final String duration;
  final String color;
  final String category; // e.g. "Instrumental"
  final String imageAsset;
  final String audioAsset;

  Track({
    required this.id,
    required this.trackType,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.color,
    required this.category,
    required this.imageAsset,
    required this.audioAsset,
  });

  Map<String, dynamic> toMap() {
    return {
      'trackType': trackType,
      'title': title,
      'subtitle': subtitle,
      'duration': duration,
      'color': color,
      'category': category,
      'imageAsset': imageAsset,
      'audioAsset': audioAsset,
    };
  }

  factory Track.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Track(
      id: doc.id,
      trackType: data['trackType'] ?? 'music',
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      duration: data['duration'] ?? '',
      color: data['color'] ?? '#FFFFFF',
      category: data['category'] ?? '',
      imageAsset: data['imageAsset'] ?? '',
      audioAsset: data['audioAsset'] ?? '',
    );
  }
}
