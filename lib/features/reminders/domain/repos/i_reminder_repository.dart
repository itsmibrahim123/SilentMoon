import '../entities/reminder.dart';

abstract class IReminderRepository {
  Stream<List<Reminder>> getReminders();
  Future<void> saveReminder(Reminder reminder);
  Future<void> deleteReminder(String id);
}
