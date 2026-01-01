import '../entities/reminder.dart';
import '../repos/i_reminder_repository.dart';

class GetRemindersUseCase {
  final IReminderRepository repository;

  GetRemindersUseCase(this.repository);

  Stream<List<Reminder>> call() {
    return repository.getReminders();
  }
}
