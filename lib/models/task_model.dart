class Task {
  final String title; // 작업 제목
  final DateTime date; // 작업 날짜
  final String startTime; // 시작 시간 (HH:mm 형식)
  final String endTime; // 종료 시간 (HH:mm 형식)
  final String repeat; // 반복 설정 (예: 매주, 매월 등)
  final String taskType; // 작업 유형 (예: '読書', '学習')
  final String? location; // 장소 (선택 사항)
  final String? alarm; // 알람 설정 (선택 사항)

  Task({
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.taskType,
    this.location,
    this.alarm,
  });

  // 데이터를 JSON으로 변환 (예: 서버 전송 시 사용)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'repeat': repeat,
      'taskType': taskType,
      'location': location,
      'alarm': alarm,
    };
  }

  // JSON 데이터를 Task 객체로 변환 (예: 서버에서 데이터 수신 시 사용)
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      date: DateTime.parse(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      repeat: json['repeat'],
      taskType: json['taskType'],
      location: json['location'],
      alarm: json['alarm'],
    );
  }
}
