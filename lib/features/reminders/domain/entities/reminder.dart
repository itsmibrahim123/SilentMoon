import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  final String id;
  final Timestamp time;
  final List<String> days;
  final bool isActive;

  Reminder({
    required this.id,
    required this.time,
    required this.days,
    required this.isActive,
  });
}
