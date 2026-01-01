import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/track_model.dart';
import '../../domain/entities/track.dart';

abstract class TrackRemoteDataSource {
  Future<List<Track>> getTracks();
}

class TrackRemoteDataSourceImpl implements TrackRemoteDataSource {
  final FirebaseFirestore firestore;

  TrackRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<Track>> getTracks() async {
    try {
      final snapshot = await firestore.collection('tracks').get();
      return snapshot.docs.map((doc) => TrackModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception('Failed to fetch tracks: $e');
    }
  }
}