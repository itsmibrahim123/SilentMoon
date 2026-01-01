import '../entities/reminder.dart';
import '../repos/i_reminder_repository.dart';

class SaveReminderUseCase {
  final IReminderRepository repository;

  SaveReminderUseCase(this.repository);

  Future<void> call(Reminder reminder) {
    return repository.saveReminder(reminder);
  }
}
