import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/reminder.dart';

class ReminderModel extends Reminder {
  ReminderModel({
    required super.id,
    required super.time,
    required super.days,
    required super.isActive,
  });

  factory ReminderModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ReminderModel(
      id: doc.id,
      time: data['time'] as Timestamp,
      days: List<String>.from(data['days'] ?? []),
      isActive: data['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'days': days,
      'isActive': isActive,
    };
  }
}
