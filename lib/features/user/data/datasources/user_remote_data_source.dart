import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRemoteDataSource {
  Future<void> toggleFavorite(Map<String, dynamic> data);
  Future<void> toggleDownload(Map<String, dynamic> data);
  Future<List<String>> getFavorites();
  Future<List<String>> getDownloads();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  UserRemoteDataSourceImpl({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  @override
  Future<void> toggleFavorite(Map<String, dynamic> data) async {
    final itemId = data['id'];
    final docRef = _firestore
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .doc(itemId);

    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      await docRef.delete();
    } else {
      await docRef.set({
        ...data,
        'addedAt': FieldValue.serverTimestamp(), // Use addedAt to match FavoriteModel sort
      });
    }
  }

  @override
  Future<void> toggleDownload(Map<String, dynamic> data) async {
    final itemId = data['id'];
    final docRef = _firestore
        .collection('users')
        .doc(_uid)
        .collection('downloads')
        .doc(itemId);

    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      await docRef.delete();
    } else {
      await docRef.set({
        ...data,
        'downloadedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Future<List<String>> getFavorites() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .get();

    return snapshot.docs.map((doc) => doc.id).toList();
  }

  @override
  Future<List<String>> getDownloads() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('downloads')
        .get();

    return snapshot.docs.map((doc) => doc.id).toList();
  }
}
