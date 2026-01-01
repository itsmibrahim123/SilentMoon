import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/session_model.dart';
import '../../domain/entities/session.dart';

abstract class SessionRemoteDataSource {
  Future<List<Session>> getSessions();
}

class SessionRemoteDataSourceImpl implements SessionRemoteDataSource {
  final FirebaseFirestore firestore;

  SessionRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<Session>> getSessions() async {
    try {
      final snapshot = await firestore.collection('sessions').get();
      return snapshot.docs.map((doc) => SessionModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception('Failed to fetch sessions: $e');
    }
  }
}