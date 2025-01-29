import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../utils/local_notifications_helper.dart';

class NewTaskViewModel extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 18, minute: 0);
  Repeat _repeat = Repeat.weekly;
  String _taskType = '読書';
  String? _location;
  String? _alarm;

  DateTime get selectedDate => _selectedDate;
  TimeOfDay get startTime => _startTime;
  TimeOfDay get endTime => _endTime;
  Repeat get repeat => _repeat;
  String get taskType => _taskType;
  String? get location => _location;
  String? get alarm => _alarm;

  NewTaskViewModel() {
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    await LocalNotificationsHelper.initialize();
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setStartTime(TimeOfDay time) {
    _startTime = time;
    notifyListeners();
  }

  void setEndTime(TimeOfDay time) {
    _endTime = time;
    notifyListeners();
  }

  void setRepeat(Repeat repeatOption) {
    _repeat = repeatOption;
    notifyListeners();
  }

  void setTaskType(String type) {
    _taskType = type;
    notifyListeners();
  }

  void setLocation(String? loc) {
    _location = loc;
    notifyListeners();
  }

  void setAlarm(BuildContext context, TimeOfDay alarmTime) {
    _alarm =
        '${alarmTime.hour.toString().padLeft(2, '0')}:${alarmTime.minute.toString().padLeft(2, '0')}';

    LocalNotificationsHelper.scheduleNotification(
      context, // contextを含めて呼び出し
      1,
      "タスクリマインダー",
      "予定されたタスクの時間です！",
      alarmTime,
    );

    notifyListeners();
  }

  void saveTask() {
    Task newTask = Task(
      title: _taskType,
      date: _selectedDate,
      startTime:
          '${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}',
      endTime:
          '${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}',
      repeat: _repeat,
      taskType: _taskType,
      location: _location,
      alarm: _alarm,
    );

    debugPrint("Task Saved: ${newTask.toJson()}");
  }
}
