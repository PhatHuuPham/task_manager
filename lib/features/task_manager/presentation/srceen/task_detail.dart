import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/task_manager/logic/providers/task_provider.dart';

class TaskDetailPage extends StatefulWidget {
  final String taskId;

  const TaskDetailPage({super.key, required this.taskId});

  @override
  // ignore: library_private_types_in_public_api
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String date = '';
  String time = '';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  @override
  void initState() {
    super.initState();
    _loadTaskData();
  }

  void _loadTaskData() async {
    DocumentSnapshot taskDoc =
        await _firestore.collection('tasks').doc(widget.taskId).get();
    if (taskDoc.exists) {
      setState(() {
        _titleController.text = taskDoc['name'];
        _descriptionController.text = taskDoc['description'];
        date = taskDoc['date'];
        time = taskDoc['time'];
      });
    }
  }

  void _updateTask() async {
    await _firestore.collection('tasks').doc(widget.taskId).update({
      'name': _titleController.text,
      'description': _descriptionController.text,
      'date': date,
      'time': time,
    });
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void _deleteTask() async {
    await _firestore.collection('tasks').doc(widget.taskId).delete();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        chageDate();
      });
    });
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = pickedTime;
        chageTime();
      });
    });
  }

  void chageDate() {
    if (_selectedDate != null) {
      setState(() {
        date = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  void chageTime() {
    if (_selectedTime != null) {
      setState(() {
        time = _selectedTime!.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: Consumer<TaskProvider>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Task Detail'),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: _deleteTask,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? date
                              : ' ${DateFormat.yMd().format(_selectedDate!)}',
                        ),
                      ),
                      TextButton(
                        onPressed: _showDatePicker,
                        child: const Text('Choose Date'),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedTime == null
                              ? time
                              : ' ${_selectedTime!.format(context)}',
                        ),
                      ),
                      TextButton(
                        onPressed: _showTimePicker,
                        child: const Text('Choose Time'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updateTask,
                  child: const Text('Update Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
