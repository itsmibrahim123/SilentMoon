import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/usecases/get_reminders_use_case.dart';
import '../../domain/usecases/save_reminder_use_case.dart';

class ReminderProvider extends ChangeNotifier {
  final GetRemindersUseCase getRemindersUseCase;
  final SaveReminderUseCase saveReminderUseCase;

  List<Reminder> _reminders = [];
  List<Reminder> get reminders => _reminders;

  StreamSubscription? _subscription;

  ReminderProvider({
    required this.getRemindersUseCase,
    required this.saveReminderUseCase,
  }) {
    _init();
  }

  void _init() {
    _subscription = getRemindersUseCase().listen((data) {
      _reminders = data;
      notifyListeners();
    });
  }

  Future<void> saveReminder(Reminder reminder) async {
    await saveReminderUseCase(reminder);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
