import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task_model.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 18, minute: 0);
  Repeat _repeat = Repeat.none;
  String _taskType = '読書';
  final List<String> _taskTypes = [
    '読書',
    '学習',
  ];

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

  void _saveTask() {
    if (_startTime.hour > _endTime.hour ||
        (_startTime.hour == _endTime.hour &&
            _startTime.minute >= _endTime.minute)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('終了時間は開始時間より後である必要があります。'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final newTask = Task(
      title: _taskType,
      date: _selectedDay ?? _focusedDay,
      startTime: _startTime.format(context),
      endTime: _endTime.format(context),
      repeat: _repeat,
      taskType: _taskType,
      location: "読書", // default
      alarm: "15分前", // default
    );

    debugPrint(newTask.toJson().toString());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('タスクが保存されました！'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF3E7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '新しいタスク',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimePicker('Starts', _startTime, true),
                _buildTimePicker('Ends', _endTime, false),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Repeat', style: TextStyle(color: Colors.orange)),
                const SizedBox(width: 16),
                DropdownButton<Repeat>(
                  value: _repeat,
                  items: Repeat.values
                      .map((repeat) => DropdownMenuItem(
                            value: repeat,
                            child: Text(repeat.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _repeat = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              children: _taskTypes
                  .map((type) =>
                      _buildTagButton(type, Colors.orange, _taskType == type))
                  .toList(),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: _saveTask,
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text('Save', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBCE4A3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker(String label, TimeOfDay time, bool isStartTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.orange)),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () => _selectTime(context, isStartTime),
          child: Text(
            time.format(context),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
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
