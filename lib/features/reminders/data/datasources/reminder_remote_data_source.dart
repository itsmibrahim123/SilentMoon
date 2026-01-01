import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/reminder_model.dart';
import '../../domain/entities/reminder.dart';

abstract class ReminderRemoteDataSource {
  Stream<List<Reminder>> getReminders();
  Future<void> saveReminder(Reminder reminder);
  Future<void> deleteReminder(String id);
}

class ReminderRemoteDataSourceImpl implements ReminderRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ReminderRemoteDataSourceImpl({
    required this.firestore,
    required this.auth,
  });

  @override
  Stream<List<Reminder>> getReminders() {
    return auth.authStateChanges().asyncExpand((user) {
      if (user == null) return Stream.value([]);
      return firestore
          .collection('users')
          .doc(user.uid)
          .collection('reminders')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => ReminderModel.fromSnapshot(doc))
            .toList();
      });
    });
  }

  @override
  Future<void> saveReminder(Reminder reminder) async {
    final user = auth.currentUser;
    if (user == null) return;

    final model = ReminderModel(
      id: reminder.id,
      time: reminder.time,
      days: reminder.days,
      isActive: reminder.isActive,
    );

    final ref = firestore
        .collection('users')
        .doc(user.uid)
        .collection('reminders')
        .doc(reminder.id.isEmpty ? null : reminder.id); // Auto-id if empty

    if (reminder.id.isEmpty) {
      await ref.set(model.toMap());
    } else {
      await ref.update(model.toMap());
    }
  }

  @override
  Future<void> deleteReminder(String id) async {
    final user = auth.currentUser;
    if (user == null) return;

    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('reminders')
        .doc(id)
        .delete();
  }
}
