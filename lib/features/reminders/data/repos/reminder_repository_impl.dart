import '../../domain/entities/reminder.dart';
import '../../domain/repos/i_reminder_repository.dart';
import '../datasources/reminder_remote_data_source.dart';

class ReminderRepositoryImpl implements IReminderRepository {
  final ReminderRemoteDataSource remoteDataSource;

  ReminderRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<Reminder>> getReminders() {
    return remoteDataSource.getReminders();
  }

  @override
  Future<void> saveReminder(Reminder reminder) {
    return remoteDataSource.saveReminder(reminder);
  }

  @override
  Future<void> deleteReminder(String id) {
    return remoteDataSource.deleteReminder(id);
  }
}
