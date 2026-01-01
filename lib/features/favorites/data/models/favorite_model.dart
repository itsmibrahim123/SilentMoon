import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/favorite.dart';

class FavoriteModel extends Favorite {
  FavoriteModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.imageUrl,
    required super.color,
    required super.type,
  });

  factory FavoriteModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteModel(
      id: doc.id, // Usually the document ID is the item ID
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      color: data['color'] ?? '#FFFFFF',
      type: data['type'] ?? 'track',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'color': color,
      'type': type,
      'addedAt': FieldValue.serverTimestamp(),
    };
  }
}
