import 'package:flutter/material.dart';
import 'package:planus/models/task_model.dart';
import 'package:table_calendar/table_calendar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

void createTask() {
  Task newTask = Task(
    title: "読書",
    date: DateTime(2025, 1, 3),
    startTime: "09:00",
    endTime: "18:00",
    repeat: "毎週",
    taskType: "読書",
    location: "Library",
    alarm: "15분 전",
  );

  debugPrint(newTask.toJson().toString());
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 18, minute: 0);
  final String _repeat = '毎週';
  String _taskType = '読書';

  void _selectTime(BuildContext context, bool isStartTime) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF3E7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.create, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'カレンダー',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 캘린더
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon:
                        Icon(Icons.chevron_left, color: Colors.orange),
                    rightChevronIcon:
                        Icon(Icons.chevron_right, color: Colors.orange),
                  ),
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Color(0xFFFFF3C5),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Color(0xFFF5C869),
                      shape: BoxShape.circle,
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Task Title',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            // 시작 시간과 종료 시간
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Starts',
                        style: TextStyle(color: Colors.orange)),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _selectTime(context, true),
                      child: Text(
                        '${_selectedDay != null ? _selectedDay!.toLocal().toString().split(' ')[0] : DateTime.now().toLocal().toString().split(' ')[0]} ${_startTime.format(context)}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ends', style: TextStyle(color: Colors.orange)),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _selectTime(context, false),
                      child: Text(
                        '${_selectedDay != null ? _selectedDay!.toLocal().toString().split(' ')[0] : DateTime.now().toLocal().toString().split(' ')[0]} ${_endTime.format(context)}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Repeat', style: TextStyle(color: Colors.orange)),
                Text(_repeat, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            // 태그 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTagButton('読書', Colors.orange, _taskType == '読書'),
                _buildTagButton('学習', Colors.green, _taskType == '学習'),
              ],
            ),
            const Spacer(),
            // 저장 버튼
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // 저장 로직 추가
                  debugPrint('Task Saved!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBCE4A3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Save',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagButton(String text, Color color, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _taskType = text;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? color : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(text),
    );
  }
}
