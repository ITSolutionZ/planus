enum Repeat {
  none,
  daily,
  weekly,
  monthly,
}

enum TaskType {
  reading,
  studying,
}

class Task {
  final String title;
  final DateTime date;
  final String startTime;
  final String endTime;
  final Repeat repeat;
  final String taskType;
  final String? location;
  final String? alarm;
  bool isCompleted;

  Task({
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.taskType,
    this.location,
    this.alarm,
    this.isCompleted = false,
  }) {
    //　時刻有効性チェック
    final timeRegex = RegExp(r'^\d{2}:\d{2}$');
    if (!timeRegex.hasMatch(startTime)) {
      throw ArgumentError('startTime은 HH:mm形式');
    }
    if (!timeRegex.hasMatch(endTime)) {
      throw ArgumentError('endTime은 HH:mm 形式');
    }

    // 開始時間が終了時間より後であることを確認
    if (_compareTimes(startTime, endTime) >= 0) {
      throw ArgumentError('endTimeは startTime 以降');
    }
  }

  // 時刻比較
  int _compareTimes(String time1, String time2) {
    final time1Parts = time1.split(':').map(int.parse).toList();
    final time2Parts = time2.split(':').map(int.parse).toList();

    final minutes1 = time1Parts[0] * 60 + time1Parts[1];
    final minutes2 = time2Parts[0] * 60 + time2Parts[1];

    return minutes1.compareTo(minutes2);
  }

  // JSONに 変更
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'repeat': repeat.name,
      'taskType': taskType,
      'location': location,
      'alarm': alarm,
      'isCompleted': isCompleted,
    };
  }

  // JSONでモデル作成
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      date: DateTime.parse(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      repeat: Repeat.values.firstWhere((e) => e.name == json['repeat'],
          orElse: () => Repeat.none),
      taskType: json['taskType'],
      location: json['location'],
      alarm: json['alarm'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Task(title: $title, date: $date, startTime: $startTime, endTime: $endTime, repeat: $repeat, taskType: $taskType, location: $location, alarm: $alarm, isCompleted: $isCompleted)';
  }
}
