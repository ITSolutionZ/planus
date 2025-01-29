import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../viewmodels/new_task_viewmodel.dart';
import '../components/custom_button.dart';
import '../models/task_model.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewTaskViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFDF3E7),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'カレンダー',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
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
          child: Consumer<NewTaskViewModel>(
            builder: (context, viewModel, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCalendar(context, viewModel),
                  _buildTimePicker(
                      context, 'Starts', viewModel.startTime, true, viewModel),
                  _buildTimePicker(
                      context, 'Ends', viewModel.endTime, false, viewModel),
                  _buildRepeatPicker(context, viewModel),
                  _buildTaskTypePicker(context, viewModel),
                  _buildLocationPicker(context, viewModel),
                  _buildAlarmPicker(context, viewModel),
                  const Spacer(),
                  CustomButton(
                    text: 'Save',
                    onPressed: () {
                      viewModel.saveTask();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar(BuildContext context, NewTaskViewModel viewModel) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2000, 1, 1),
          lastDay: DateTime.utc(2100, 12, 31),
          focusedDay: viewModel.selectedDate,
          selectedDayPredicate: (day) => isSameDay(viewModel.selectedDate, day),
          onDaySelected: (selectedDay, focusedDay) {
            viewModel.setDate(selectedDay);
          },
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.orange),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.orange),
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
    );
  }

  Widget _buildTimePicker(BuildContext context, String label, TimeOfDay time,
      bool isStart, NewTaskViewModel viewModel) {
    return ListTile(
      title: Text(label, style: const TextStyle(color: Colors.orange)),
      trailing: Text(time.format(context)),
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: time,
        );
        if (pickedTime != null) {
          isStart
              ? viewModel.setStartTime(pickedTime)
              : viewModel.setEndTime(pickedTime);
        }
      },
    );
  }

  Widget _buildRepeatPicker(BuildContext context, NewTaskViewModel viewModel) {
    return ListTile(
      title: const Text('Repeat', style: TextStyle(color: Colors.orange)),
      trailing: DropdownButton<Repeat>(
        value: viewModel.repeat,
        items: Repeat.values
            .map((repeat) => DropdownMenuItem(
                  value: repeat,
                  child: Text(repeat.name),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) viewModel.setRepeat(value);
        },
      ),
    );
  }

  Widget _buildTaskTypePicker(
      BuildContext context, NewTaskViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTaskTypeButton(context, '読書', Colors.orange, viewModel),
        _buildTaskTypeButton(context, '学習', Colors.green, viewModel),
      ],
    );
  }

  Widget _buildTaskTypeButton(BuildContext context, String type, Color color,
      NewTaskViewModel viewModel) {
    return ElevatedButton(
      onPressed: () => viewModel.setTaskType(type),
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(type),
    );
  }

  Widget _buildLocationPicker(
      BuildContext context, NewTaskViewModel viewModel) {
    return ListTile(
      leading: const Icon(Icons.location_on, color: Colors.orange),
      title: const Text('場所選択', style: TextStyle(color: Colors.orange)),
      trailing: Text(viewModel.location ?? '未設定'),
      onTap: () async {
        String? selectedLocation = await _showLocationDialog(context);
        if (selectedLocation != null) {
          viewModel.setLocation(selectedLocation);
        }
      },
    );
  }

  Future<String?> _showLocationDialog(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('場所を入力'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  Widget _buildAlarmPicker(BuildContext context, NewTaskViewModel viewModel) {
    return ListTile(
      leading: const Icon(Icons.alarm, color: Colors.orange),
      title: const Text('アラーム設定', style: TextStyle(color: Colors.orange)),
      trailing: Text(viewModel.alarm ?? '未設定'),
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (context.mounted && pickedTime != null) {
          viewModel.setAlarm(context, pickedTime);
        }
      },
    );
  }
}
