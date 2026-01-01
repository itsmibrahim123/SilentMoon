import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/track_model.dart';
import '../../domain/entities/track.dart';

abstract class TrackRemoteDataSource {
  Stream<Track?> getTrackStream(String trackId);
}

class TrackRemoteDataSourceImpl implements TrackRemoteDataSource {
  final FirebaseFirestore firestore;

  TrackRemoteDataSourceImpl({required this.firestore});

  @override
  Stream<Track?> getTrackStream(String trackId) {
    return firestore
        .collection('tracks')
        .doc(trackId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return null;
      }
      return TrackModel.fromSnapshot(snapshot);
    });
  }
}

