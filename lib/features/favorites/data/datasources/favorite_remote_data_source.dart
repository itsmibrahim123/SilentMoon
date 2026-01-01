import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/favorite_model.dart';
import '../../domain/entities/favorite.dart';

abstract class FavoriteRemoteDataSource {
  Stream<List<Favorite>> getFavorites();
  Future<void> toggleFavorite(Favorite favorite);
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FavoriteRemoteDataSourceImpl({
    required this.auth,
    required this.firestore,
  });

  @override
  Stream<List<Favorite>> getFavorites() {
    return auth.authStateChanges().asyncExpand((user) {
      if (user == null) return Stream.value([]);
      return firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .orderBy('addedAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => FavoriteModel.fromSnapshot(doc))
            .toList();
      });
    });
  }

  @override
  Future<void> toggleFavorite(Favorite favorite) async {
    final user = auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final ref = firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(favorite.id);

    final doc = await ref.get();
    if (doc.exists) {
      await ref.delete();
    } else {
      // Cast to Model to access toMap
      final model = FavoriteModel(
        id: favorite.id,
        title: favorite.title,
        subtitle: favorite.subtitle,
        imageUrl: favorite.imageUrl,
        color: favorite.color,
        type: favorite.type,
      );
      await ref.set(model.toMap());
    }
  }
}
